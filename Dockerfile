FROM cloudbees/jnlp-slave-with-java-build-tools
USER root

ARG EJSON_KEY
ENV CLOUDSDK_CORE_DISABLE_PROMPTS 1
ENV PATH /opt/google-cloud-sdk/bin:$PATH
RUN apt-get update \
    && apt-get install -y \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
    && apt-get update \
    && apt-cache policy docker-ce \
    && apt-get install docker-ce -y \
    && apt-get install -y \
        ruby-full \
        git \
    && gem install kubernetes-deploy \
    && gem install ejson \
    && mkdir -p /opt/ejson/keys \
    && touch /opt/ejson/keys/0bfab4cc0d0af048d90f3d83afd1deaf55d0bab1a5a825e38e4fc08353df7746 \
    && chmod 0440 /opt/ejson/keys/0bfab4cc0d0af048d90f3d83afd1deaf55d0bab1a5a825e38e4fc08353df7746 \
    && echo "${EJSON_KEY}" > /opt/ejson/keys/0bfab4cc0d0af048d90f3d83afd1deaf55d0bab1a5a825e38e4fc08353df7746 \
    && curl -s https://sdk.cloud.google.com \
        | bash \
     && mv /root/google-cloud-sdk /opt \ 
     && gcloud components install beta