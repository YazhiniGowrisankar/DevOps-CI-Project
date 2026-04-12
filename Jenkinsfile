pipeline {
    agent any

    environment {
        IMAGE = "yazhinigp/my-website:latest"
        CONTAINER = "myapp"
        PORT = "8081"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh '''
                    echo $PASS | docker login -u $USER --password-stdin
                    docker push $IMAGE
                    '''
                }
            }
        }

        stage('Deploy Container') {
            steps {
                sh '''
                echo "Stopping old container if exists..."
                docker rm -f $CONTAINER || true

                echo "Removing any container using port 8081..."
                docker ps -q --filter "publish=$PORT" | xargs -r docker rm -f

                echo "Running new container..."
                docker run -d -p $PORT:80 --name $CONTAINER $IMAGE
                '''
            }
        }
    }
}