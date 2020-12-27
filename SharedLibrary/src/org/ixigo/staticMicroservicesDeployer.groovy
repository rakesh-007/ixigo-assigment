package org.ixigo
import org.jenkinsci.plugins.workflow.steps.FlowInterruptedException

def staticDeployer(artifact,app_name,env_name,git_url) {
    def nodelabel = "master"
    node(nodelabel) {
         wrap([$class: 'BuildUser']) {
         def user = env.BUILD_USER_ID

        stage("Initializing Job Properties") {
                if(("${user}" == "null"))
		    user = "Github Commit"
		checkout scm
        }
        
	stage("Cloning Helm_Charts for Deployment") {
                if(("${user}" == "null"))
		    user = "Github Commit"
		sh "rm -rf *"
		git branch: "${branch_name}", credentialsId: "", url: "${git_url}"  
        }
		 
        
    try { 
	      stage("Rolling deployment") {
		sh "echo $env_name"      
		sh "helm upgrade ${app_name}-${env_name}-deployment ${env.WORKSPACE}/${app_name}-${env_name} --set ${env_name}.tag=$artifact"      
        }
	    catch (Exception e) {
            echo e.toString()
            slackCall("FAILURE", "${user}")
            throw e
        }
        
        try {
            stage("Sending slack notification") {
            	slackCall("SUCCESS", "${user}")
                }   
            } catch (Exception e) {
            echo "Unable to send slack notification !!! Please check logs"
            echo e.toString()
            throw e
	}
	}
    }
}

def slackCall(buildResult, buildUser) {
  if ( buildResult == "SUCCESS" ) {
    slackSend color: "good", message: "Job: ${env.JOB_NAME} started by ${buildUser} with buildnumber ${env.BUILD_NUMBER} was successful"
  }
  else if( buildResult == "FAILURE" ) {
    slackSend color: "danger", message: "Job: ${env.JOB_NAME} started by ${buildUser} with buildnumber ${env.BUILD_NUMBER} was failed"
  }
  else if( buildResult == "UNSTABLE" ) {
    slackSend color: "warning", message: "Job: ${env.JOB_NAME} started by ${buildUser} with buildnumber ${env.BUILD_NUMBER} was unstable"
  }
  else {
    slackSend color: "danger", message: "Job: ${env.JOB_NAME} started by ${buildUser} with buildnumber ${env.BUILD_NUMBER} its result was unclear"
  }
}


