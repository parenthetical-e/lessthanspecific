SHELL:=/bin/bash
BINPATH=~/Code/modelmodel/bin


# Quick test

test: data/rwset10_*.csv data/rwset10_l_params_tvalue_conj.csv
	
data/rwset10_*.csv: data/rwset10_l.hdf5
	python $(BINPATH)/extract.py \
		--hdf data/rwset10_l.hdf5 \
		--names \
			data/rwset10_l_params_tvalue.csv \
		 	data/rwset10_l_params_pvalue.csv \
		--paths \
			 /*/*/t \
			 /*/*/p \
		--dims 1 1

data/rwset10_l_params_tvalue_conj.csv: data/rwset10_l_params_tvalue.csv data/rwset10_l_params_pvalue.csv
	python $(BINPATH)/conjunction.py \
		data/rwset10_l_params_tvalue_conj.csv \
		data/rwset10_l_params_tvalue.csv \
		data/rwset10_l_params_pvalue.csv \
		--drop 0

# ---------
# Get stats
# ---------
clean_extract: clean_rwset500_l clean_rwset500_r
	
extract: data/rwset500_l*.csv data/rwset500_r*.csv
	
# set
# learn
clean_rwset500_l:
	-rm data/rwset500_l_fvalue.csv
	-rm data/rwset500_l_pvalue.csv
	-rm data/rwset500_l_omni_fvalue.csv
	-rm data/rwset500_l_params_tvalue.csv
	-rm data/rwset500_l_params_pvalue.csv
	-rm data/rwset500_l_aic.csv

data/rwset500_l*.csv: data/rwset500_l.hdf5
	python $(BINPATH)/extract.py \
		--hdf data/rwset500_l.hdf5 \
		--names \
		 data/rwset500_l_fvalue.csv \
		 data/rwset500_l_pvalue.csv \
		 data/rwset500_l_omni_fvalue.csv \
		 data/rwset500_l_params_tvalue.csv \
		 data/rwset500_l_params_pvalue.csv \
		 data/rwset500_l_aic.csv \
		--paths \
		 /*/*/tests/fvalue \
		 /*/*/tests/pvalue \
		 /*/*/fvalue \
		 /*/*/t \
		 /*/*/p \
		 /*/*/aic \
		--dims \
		 0 \
		 0 \
		 0 \
		 1 \
		 1 \
		 0

# random
clean_rwset500_r:
	-rm data/rwset500_r_fvalue.csv 
	-rm data/rwset500_r_pvalue.csv 
	-rm data/rwset500_r_omni_fvalue.csv 
	-rm data/rwset500_r_params_tvalue.csv 
	-rm data/rwset500_r_params_pvalue.csv 
	-rm data/rwset500_r_aic.csv 
		
data/rwset500_r*.csv: data/rwset500_r.hdf5
	python $(BINPATH)/extract.py \
		--hdf data/rwset500_r.hdf5 \
		--names \
		 data/rwset500_r_fvalue.csv \
		 data/rwset500_r_pvalue.csv \
		 data/rwset500_r_omni_fvalue.csv \
		 data/rwset500_r_params_tvalue.csv \
		 data/rwset500_r_params_pvalue.csv \
		 data/rwset500_r_aic.csv \
		--paths \
		 /*/*/tests/fvalue \
		 /*/*/tests/pvalue \
		 /*/*/fvalue \
		 /*/*/t \
		 /*/*/p \
		 /*/*/aic \
		--dims \
		 0 \
		 0 \
		 0 \
		 1 \
		 1 \
		 0

# -----------
# conjunction
# -----------
clean_conjuction: 
	-rm data/rwset500_l_params_tvalue_conj.csv
	-rm data/rwset500_r_params_tvalue_conj.csv
	
conjunction: data/rwset500_l_params_tvalue_conj.csv data/rwset500_r_params_tvalue_conj.csv
	
	
data/rwset500_l_params_tvalue_conj.csv: data/rwset500_l_params_tvalue.csv data/rwset500_l_params_pvalue.csv
	python $(BINPATH)/conjunction.py \
		data/rwset500_l_params_tvalue_conj.csv \
		data/rwset500_l_params_tvalue.csv \
		data/rwset500_l_params_pvalue.csv \
		--drop 0

data/rwset500_r_params_tvalue_conj.csv: data/rwset500_r_params_tvalue.csv data/rwset500_r_params_pvalue.csv
	python $(BINPATH)/conjunction.py \
		data/rwset500_r_params_tvalue_conj.csv \
		data/rwset500_r_params_tvalue.csv \
		data/rwset500_r_params_pvalue.csv \
		--drop 0

