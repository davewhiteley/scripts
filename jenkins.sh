# This is a collection of Jenkins-related commands and snippets.
# Navigate to the Jenkins Script Console <Jenkins URL>/script to run these.

# Prevent users from accidentally running this entire file as a script
exit 0

# Get a list of installed plugins in shortName:version format (good for plugins.txt)
Jenkins.instance.pluginManager.plugins.each{
  plugin -> 
    println ("${plugin.getShortName()}:${plugin.getVersion()}")
}

# Decrypt stored credentials
# https://devops.stackexchange.com/questions/2191/how-to-decrypt-jenkins-passwords-from-credentials-xml
# replacing {XXX=} with the credential
println(hudson.util.Secret.decrypt("{XXX=}"))
