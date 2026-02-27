function pig {
    # Get the project code based on the current directory
    project_json="$(project json)"
    project_code="$(echo "$project_json" | jq .code -r)"
    installer_script="$HOME/projects/exports/installers/${project_code}.sh"

    cat "$installer_script";
    return;
}


function pdg {
    # Get the project code based on the current directory
    project_json="$(project json)"
    project_code="$(echo "$project_json" | jq .code -r)"
    uninstaller_script="$HOME/projects/exports/uninstallers/${project_code}.sh"

    cat "$uninstaller_script";
    return;
}

function pi {
    project_json="$(project json)"

    project_code="$(echo "$project_json" | jq .code -r)"
    installer_script="$HOME/projects/exports/installers/${project_code}.sh"

    # Look if there is an uninstall script on this system for that project
    # If so, execute it, else, give error
    if [[ -f "$installer_script" ]]; then
        bash "$installer_script"
    else
        echo "[error] this project does not have an installer on this system"
        return
    fi
}

function pd {
    # Get the project code based on the current directory
    project_json="$(project json)"
    project_code="$(echo "$project_json" | jq .code -r)"
    uninstaller_script="$HOME/projects/exports/uninstallers/${project_code}.sh"

    # Look if there is an uninstall script on this system for that project
    # If so, execute it, else, give error
    if [[ -f "$uninstaller_script" ]]; then
        bash "$uninstaller_script"
    else
        echo "[error] this project does not have an uninstaller on this system"
        return
    fi
}
