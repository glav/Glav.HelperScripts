"Staring SonarQube with local/non prod database"

"Go to http://localhost:9000 once started"

docker run -d --name sonarqube -e SONAR_ES_BOOTSTRAP_CHECKS_DISABLE=true -p 9000:9000 sonarqube:latest
