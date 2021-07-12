elifePipeline {
    node('containers-jenkins-plugin') {
        def commit

        stage 'Checkout', {
            checkout scm
            commit = elifeGitRevision()
        }

        stage 'Build and run tests', {
            try {
                timeout(time: 30, unit: 'MINUTES') {
                    sh "make IMAGE_TAG=${commit} ci-build-and-test"
                }
            } finally {
                sh "make ci-clean"
            }
        }

        elifeMainlineOnly {
            stage 'Merge to master', {
                elifeGitMoveToBranch commit, 'master'
            }
        }
    }
}
