
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
RESET=$(tput setaf 7)

# Build
TARGETS_DIR=targets
mkdir -p $TARGETS_DIR/x86_64 $TARGETS_DIR/ppc

# Build multiple variants to generate different compilation DBs
if [ $(which bear 1>/dev/null) ]; then
    echo -e "${YELLOW}\nbear is not installed. Skipping compilation database generation\n${RESET}"
else
    echo -e "${GREEN}\nBuilding targets and =generating compilation database for x86_64 and ppc variants\n${RESET}"
    bear -- make x86_64
    mv compile_commands.json $TARGETS_DIR/x86_64

    bear -- make ppc
    mv compile_commands.json targets/ppc
fi

# Run a basic scan - This will only analyze one variant. No issues in that variant - see main branch in sonarqube
echo -e "${GREEN}\nRunning a code variant agnostic scan. See ${YELLOW}main${GREEN} branch in SonarQube\n${RESET}"
sonar-scanner > /dev/null

# Run scanner with multiple code variants - some issues revealed in non x86_64 variant - see "variant" branch in SonarQube
echo -e "${GREEN}\nNow running a code variant aware scan. See ${YELLOW}code-variants${GREEN} branch in SonarQube\n${RESET}"
sonar-scanner -Dsonar.branch.name=all-variants \
    -Dsonar.cfamily.variants.names=x86_64,ppc \
    -Dsonar.cfamily.variants.dir=$TARGETS_DIR > /dev/null
