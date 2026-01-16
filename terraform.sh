tfinit

## DEV
tf workspace new dev
tfp -var-file=dev.tfvars
tfa -var-file=dev.tfvars

tfdt -var-file=dev.tfvars

## INT
tf workspace new int
tfp -var-file=int.tfvars
tfa -var-file=int.tfvars

tfdt -var-file=int.tfvars


## PROD
tf workspace new prod
tfp -var-file=prod.tfvars
tfa -var-file=prod.tfvars

tfdt -var-file=prod.tfvars
