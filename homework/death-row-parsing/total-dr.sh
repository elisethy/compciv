
bash ca-dr.sh | sed 's/WHI/White/' | sed 's/HIS/Hispanic/' | sed 's/BLA/Black/' | sed 's/OTH/Other/' | sed 's/^/CA,/'
bash fl-dr.sh | sed 's/BM/Black/' | sed 's/BF/Black/' | sed 's/HM/Hispanic/' | sed 's/HF/Hispanic/' | sed 's/WM/White/' | sed 's/WF/White/' | sed 's/OM/Other/' | sed 's/^/FL,/'
bash tx-dr.sh | sed 's/^/TX,/'
