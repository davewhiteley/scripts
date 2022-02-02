# This is a collection of Jenkins-related commands and snippets.

# Prevent users from accidentally running this entire file as a script
exit 0



########## COMMANDS RUN IN THE JENKINS SCRIPT CONSOLE <Jenkins URL>/script ##########

# Get a list of installed plugins in shortName:version format (good for plugins.txt)
Jenkins.instance.pluginManager.plugins.each{
  plugin -> 
    println ("${plugin.getShortName()}:${plugin.getVersion()}")
}

# Decrypt stored credentials
# https://devops.stackexchange.com/questions/2191/how-to-decrypt-jenkins-passwords-from-credentials-xml
# replacing {XXX=} with the credential
println(hudson.util.Secret.decrypt("{XXX=}"))



########## COMMANDS RUN ON JENKINS HOSTS ##########

# Find large (> 1GB) workspaces on a build agent (note workspace path)
du -hs /home/build/workspace/* | grep G
