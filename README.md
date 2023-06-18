# jenkins-cicd

Continuous Integration , Jenkins Pipeline, Nexus , Sonarqube

# About this project
1. We will create jenkins job
2. Scripted way of creating pipeline
3. Pipeline as a code 


# Tools Used for CICD 

1. Jenkins: Continuous Integration Server
2. GIT : Version Control System 
3. Maven: Build Tool for Java Code 
4. Checkstyle: Code Analysis Tool 
5. Notifications: Slack, Email Integration , Teams
6. Repository : Nexus Sonatype Artifact Repository to download dependencies for Maven 
7. Code Analysis: Sonarqube 


# Continuous Integration Execution Flow.

1. Developer from IDE(Vscode/Intellij idea) will "COMMIT the code to GITLAB/GITHUB"
2. Jenkins Continuous Integration server will "detect & Fetch" the changes 
3. Jenkins will run "Unit Test" as part to build test 
4. If test passes, code Anaylysis will be performed using CHEKCSTYLE/SONARSCANNER
5. The code Analysis report will be published on SONARQUBE Server, it will have Quality Gates
6. If Code Analysis failed, process will stop and failure notification will be sent
7. During Build, MAVEN Dependencies will be downloaded from Nexus Repository
8. Once Artifact will be packages (*.war), then software will be uploaded back to Sonatype Nexus Repository



# About Jenkinsfile 

1. Automate pipeline setup with Jenkinsfile
2. Jenkinsfile defines the stages in the CI/CD pipeline.
3. Jenkinsfile is a text file with pipeline DSL Syntax 
4. DSL is Similar to groovy 
5. Two Syntax Types
    - Scripted
    - Declarative 
6. Pipeline Concepts 
    - Pipeline
    - Node/Agent
    - Stage
    - Step 

