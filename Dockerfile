FROM cloudbees/jnlp-slave-with-java-build-tools
USER root

ENV CLOUDSDK_CORE_DISABLE_PROMPTS 1
RUN apt-get update \
    && apt-get install curl -y \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
    && apt-get update \
    && apt-cache policy docker-ce \
    && apt-get install -y docker-ce \
    && apt-get install -y \
        ruby-full \
        git \
    && gem install kubernetes-deploy \
    && gem install ejson