
#!/usr/bin/env bash
set -e

# Prompt for environment (default: dev)
# Usage: ./terraform.sh [dev|int|prd]
# In non-interactive mode, pass arg: ./terraform.sh dev
ENV="${1:-}"

if [ -z "$ENV" ]; then
    read -p "Enter environment (dev/int/prd) [dev]: " ENV
fi
ENV=${ENV:-dev}

tfinit

tfvalidate

case "$ENV" in
	dev|int|prd)
		echo "Using environment: $ENV"
		;;
	*)
		echo "Unknown environment: $ENV"
		exit 1
		;;
esac

# Ensure/select workspace, then run terraform commands with the chosen var-file
tf workspace select "$ENV" 2>/dev/null || tf workspace new "$ENV"
tfp -var-file="${ENV}.tfvars"
tfa -var-file="${ENV}.tfvars"

# Note: tfdt (destroy) commented out for safety. Uncomment to enable.
# tfdt -var-file="${ENV}.tfvars"
