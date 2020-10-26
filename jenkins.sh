# This is a collection of Jenkins-related commands and snippets

# Prevent users from accidentally running this entire file as a script
exit 0

# Decrypt / "unencrypt" stored credentials
# https://devops.stackexchange.com/questions/2191/how-to-decrypt-jenkins-passwords-from-credentials-xml
# Navigate to the Jenkins Script Console <Jenkins URL>/script
println(hudson.util.Secret.decrypt("{XXX=}"))
# replacing {XXX=} with the credential