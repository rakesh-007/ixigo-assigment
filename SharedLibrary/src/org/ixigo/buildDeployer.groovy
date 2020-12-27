package org.ixigo

def buildStaticCode(git_url, env_name, appname, branch_name) {
    def nodelabel = "master"
    def now = new Date()
    def timestamp = now.format("yyyy-MM-dd-HH", TimeZone.getTimeZone('IST'))
    node(nodelabel){
         wrap([$class: 'BuildUser']) {
         def user = env.BUILD_USER_ID
	 def build_no = env.BUILD_NUMBER

        try {
	  	
            stage("Clonning the Code Repo for Build") {
		if(("${user}" == "null"))
		    user = "Github Commit"    
                sh "sudo rm -rf *"
		sh "git clone --branch ${branch_name} ${git_url}"    
		 }
        } catch (Exception e) {
            echo "Unable to clone the ${git_url}"
            echo e.toString()
            slackCall("FAILURE", "${user}")
            throw e
        }
	try {
            stage("Validating Dockerfile") {
		    sh "docker run --rm --privileged -v ${env.WORKSPACE}/$appname/:/root/ projectatomic/dockerfile-lint dockerfile_lint ."
            }
        } catch (Exception e) {
            echo "Dockerfile Validation Failed"
            echo e.toString()
            slackCall("FAILURE", "${user}")
            throw e
        }
        try {
            stage("Building Dockerfile") {
		    sh "docker build -t ixigo:latest -f $appname/Dockerfile $appname"
            }
        } catch (Exception e) {
            echo "Unable to Build Docker images"
            echo e.toString()
            slackCall("FAILURE", "${user}")
            throw e
        }
	 try {
            stage("Checking vulnerabilities in docker images") {
                    //sh "docker build --build-arg=token=NzcwMjdmMmJmNDk3 --no-cache -f $appname/deployment/Dockerfile_security $appname"
            }
        } catch (Exception e) {
            echo "Build Failed: Docker image is not secure"
            echo e.toString()
            slackCall("FAILURE", "${user}")
            throw e
        }
		 
	try {
            stage("Pushing Image to ECR") {
		    sh "docker tag ixigo:latest 036955336065.dkr.ecr.ap-south-1.amazonaws.com/${appname}/${env_name}:${appname}-${env_name}-${timestamp}-${build_no}"
		    sh "docker push 036955336065.dkr.ecr.ap-south-1.amazonaws.com/${appname}/${env_name}:${appname}-${env_name}-${timestamp}-${build_no}"
            }
        } catch (Exception e) {
            echo "image is not getting pushed to ecr"
            echo e.toString()
            slackCall("FAILURE", "${user}")
            throw e
        } 
	try {
            stage("Prune Docker images") {
		    sh "docker rmi ixigo:latest"
		    sh "docker rmi 036955336065.dkr.ecr.ap-south-1.amazonaws.com/$appname/${env_name}:${appname}-${env_name}-${timestamp}-${build_no}"
		    sh "docker ps -q -f status=exited | xargs --no-run-if-empty docker rm"
        	    sh "docker images -q -f dangling=true | xargs --no-run-if-empty docker rmi"
                    sh "docker volume ls -qf dangling=true | xargs -r docker volume rm"
                    sh "docker image ls"
  	}
        } catch (Exception e) {
            echo "Unable to remove old docker images"
            echo e.toString()
            slackCall("FAILURE", "${user}")
            throw e
        } 
		 
		 
        
        try {
            stage("Sending slack notification") {
                slackCall("SUCCESS", "${user}")
            }   
        }       catch (Exception e) {
            echo "Unable to send slack notification"
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
    slackSend color: "warning", message: "Job: ${env.JOB_NAME} with buildnumber ${env.BUILD_NUMBER} was unstable"
  }
  else {
    slackSend color: "danger", message: "Job: ${env.JOB_NAME} with buildnumber ${env.BUILD_NUMBER} its result was unclear"
  }
}


