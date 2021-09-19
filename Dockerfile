FROM python:3-slim-buster

RUN apt update && \
  apt install -y curl

# Install Buildpack
RUN curl -L "https://github.com/buildpacks/pack/releases/download/v0.20.0/pack-v0.20.0-linux.tgz" | tar -C /usr/local/bin/ --no-same-owner -xzv pack

RUN curl -L https://vstsagentpackage.azureedge.net/agent/2.192.0/vsts-agent-linux-x64-2.192.0.tar.gz -o /tmp/agent.tar.gz

# unpack tarball and setup user ownership
RUN useradd ado-agent && mkdir /opt/agent && mkdir /home/ado-agent
RUN tar xzf /tmp/agent.tar.gz -C /opt/agent && \
    chown -R ado-agent /opt/agent

WORKDIR /opt/agent
RUN /opt/agent/bin/installdependencies.sh

USER ado-agent:ado-agent
ENTRYPOINT ./config.sh --replace --sslskipcertvalidation --work _work --acceptTeeEula --url $AZ_URL \
  --auth pat --token $AZ_PAT --agent $AZ_AGENT_NAME --pool $AZ_AGENT_POOL && ./run.sh --once