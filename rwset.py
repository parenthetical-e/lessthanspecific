import os
import shutil
import argparse
import numpy as np
import pandas as pd
import statsmodels.formula.api as smf

from patsy.builtins import scale

from modelmodel.behave import behave
from modelmodel.behave import reinforce
from modelmodel.noise import white
from modelmodel.hrf import double_gamma as dg
from modelmodel.dm import convolve_hrf
from modelmodel.dm import orthogonalize
from modelmodel.io import reformat_model
from modelmodel.io import read_models
from modelmodel.io import reformat_contrast
from modelmodel.io import merge_results
from modelmodel.io import write_hdf
from modelmodel.bold import create_bold


parser = argparse.ArgumentParser(
        description="Simulate a Rescorla Wagner experiment with preset alphas",
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
        "--behave",
        default='learn',
        help="Behavior mode ('learn', 'random')"
        )
parser.add_argument(
        "--alpha",
        type=float, nargs="+",
        help="Set alpha values"
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

# Get and parse the model.ini file and pars
model_configs = read_models(args.models)
alphas = args.alpha

# Pick which data to use as BOLD
asbold = ['box', 'value', 'rpe', 'rand']

# Main - too too nested....
results = {}
for n in range(args.N):
    n_results = {}
    
    # Create behave data (for whole iter)
    if args.behave == 'learn':
        trials, acc, p, prng = behave.learn(
                n_cond, args.n_trials, 
                loc=prng.normal(3, .3), prng=prng
                )
    elif args.behave == 'random':
        trials, acc, p, prng = behave.random(
                n_cond, args.n_trials, prng=prng
                )
    else:
        raise ValueError('--behave not understood')
    
    # There are two alphas loops. The first
    # creates the BOLD.  The second creates
    # the predictors.
    for alpha_bold in alphas:            
        # Create all bold options
        df_bold, _ = reinforce.rescorla_wagner(
                trials, acc, p, 
                alpha=alpha_bold, prng=prng
                )
        
        # Iter options
        for bold_name in asbold:
            l = df_bold.shape[0]
            noi, prng = white(l, prng=prng)
            
            df_bold['bold'] = create_bold(
                    [df_bold[bold_name].values], dg(), noi
                    )
            
            # Create predictor
            for alpha_pred in alphas:
                df_pred, _ = reinforce.rescorla_wagner(
                        trials, acc, p, 
                        alpha=alpha_pred, prng=prng
                        )

                df_pred = convolve_hrf(df_pred, dg(), asbold)
                
                # Orth select predictors
                to_orth = [['box', too] for too in asbold if too != 'box']
                for orth in to_orth:
                    df_pred[orth[1]+'_o'] = orthogonalize(
                            df_pred, orth
                            )[orth[1]]

                # Hold bold constant in the predictor loops                
                df_pred['bold'] = df_bold['bold']
                
                # Finally! Get modeling.
                for model_name, model, test, hypoth in zip(*model_configs):
                    
                    # Regress
                    smo = smf.ols(model, data=df_pred).fit()
                    print(smo.summary2())
            
                    # Hypoth
                    stato = None
                    if test == 't':
                        stato = smo.t_test(hypoth)
                    elif test == 'F':
                        stato = smo.f_test(hypoth)
                    elif test is not None:
                        raise ValueError("Unknown test")
                
                    # Reformat and update store
                    savedf = None
                    if args.save_behave: 
                        savedf = df_pred 
                    
                    n_results.update(merge_results(
                            '_'.join([
                                    bold_name, str(alpha_bold),
                                    model_name, str(alpha_pred)]
                                    ), 
                            model, 
                            smo, 
                            df=savedf, 
                            stato=stato, 
                            other=None
                            ))
    # Upate iter store
    results.update({str(n) : n_results})

# Write results at the end (only)
write_hdf(results, str(args.name))