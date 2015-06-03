import argparse
import numpy as np
import pandas as pd
import statsmodels.formula.api as smf

# from patsy.builtins import scale

from modelmodel.behave import behave
from modelmodel.behave import reinforce
from modelmodel.noise import white
from modelmodel.hrf import double_gamma as dg
from modelmodel.dm import convolve_hrf
from modelmodel.dm import orthogonalize
from modelmodel.io import read_models
from modelmodel.io import merge_results
from modelmodel.io import write_hdf
from modelmodel.bold import create_bold


parser = argparse.ArgumentParser(
        description="Compare behavoiral learning and guessing",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter
        )
parser.add_argument(
        "name", type=str,
        help="Name of this exp"
        )
parser.add_argument(
        "N",
        default=1000, type=int,
        help="Number of iterations"
        )
parser.add_argument(
        "--n_trials",
        default=60, type=int,
        help="Number of trials / cond"
        )
parser.add_argument(
        "--models", type=str, nargs=1,
        help="The models file (.ini)"
        )
parser.add_argument(
        "--save_behave", type=bool, default=False,
        help="Save the behave data?"
        )
parser.add_argument(
        "--seed",
        default=42, type=int,
        help="RandomState seed"
        )
args = parser.parse_args()
prng = np.random.RandomState(args.seed)

n_cond = 1

# Get and parse the model.ini file
model_configs = read_models(args.models)

# Pick which data to use as BOLD
asbold = ['box', 'value', 'rpe']
asbold2 = ['box', 'value_l', 'rpe_l', 'value_r', 'rpe_r']

# Regress for each BOLD, and model for N interations
results = {}
for n in range(args.N):
    print("Iteration {0}".format(n))

    # Create data
    loc = prng.normal(3, .3)

    # Reset seed for identical random trials
    prng.seed(args.seed + n)
    trials_l, acc_l, p_l, prng = behave.learn(
        n_cond, args.n_trials,
        loc=loc, prng=prng
    )
    prng.seed(args.seed + n)
    trials_r, acc_r, p_r, prng = behave.random(
        n_cond, args.n_trials, prng=prng
    )
    assert np.alltrue(trials_r == trials_l), "Trial locations don't match"

    df_l, rlpars_l = reinforce.rescorla_wagner(trials_l, acc_l, p_l, prng=prng)
    df_r, rlpars_r = reinforce.rescorla_wagner(trials_r, acc_r, p_r, prng=prng)

    # Convolve with HRF
    df_l = convolve_hrf(df_l, dg(), asbold)
    df_r = convolve_hrf(df_r, dg(), asbold)

    # Orth select regressors
    to_orth = [['box', too] for too in asbold if too != 'box']
    for orth in to_orth:
        df_l[orth[1]+'_o'] = orthogonalize(df_l, orth)[orth[1]]
        df_r[orth[1]+'_o'] = orthogonalize(df_r, orth)[orth[1]]

    # Join data sets and params
    df = pd.DataFrame({
        "box" : df_l['box'],
        "rpe_l" : df_l['rpe'],
        "value_l" : df_l['value'],
        "rpe_r" : df_r['rpe'],
        "value_r" : df_r['value'],
        "rpe_l_o" : df_l['rpe_o'],
        "value_l_o" : df_l['value_o'],
        "rpe_r_o" : df_r['rpe_o'],
        "value_r_o" : df_r['value_o']
    })
    rlpars = {
        'best_logL_l' : rlpars_l['best_logL'],
        'best_rl_pars_l' : rlpars_l['best_rl_pars'],
        'best_rogL_r' : rlpars_r['best_logL'],
        'best_rl_pars_r' : rlpars_r['best_rl_pars']
    }

    # Do the regressions
    n_results = {}
    for model_name, model, test, hypoth in zip(*model_configs):
        for bold_name in asbold2:
            l = df.shape[0]
            noi, prng = white(l, prng=prng)

            # Make bold
            df['bold'] = create_bold([df[bold_name].values], None, noi)

            # Regress
            smo = smf.ols(model, data=df).fit()
            print(smo.summary2())

            # Hypoth test
            stato = None
            if test == 't':
                stato = smo.t_test(hypoth)
            elif test == 'F':
                stato = smo.f_test(hypoth)
            elif test is not None:
                raise ValueError("Unknown test")

            # Reformat
            savedf = None
            if args.save_behave:
                savedf = df

            n_results.update(merge_results(
                bold_name + '_' + model_name,
                model, smo, df=savedf, stato=stato,
                other=rlpars
            ))

    results.update({str(n) : n_results})

write_hdf(results, str(args.name))
