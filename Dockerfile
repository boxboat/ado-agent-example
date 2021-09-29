FROM python:3-slim-buster

RUN apt update && \
  apt install -y curl

# create directories for our agent files
RUN mkdir /opt/agent && mkdir /home/ado-agent && \
# download and unpack tarball
    curl -L https://vstsagentpackage.azureedge.net/agent/2.192.0/vsts-agent-linux-x64-2.192.0.tar.gz -o /tmp/agent.tar.gz && tar xzf /tmp/agent.tar.gz -C /opt/agent && \
# create user and assign ownership
    useradd ado-agent && chown -R ado-agent /opt/agent

WORKDIR /opt/agent
RUN /opt/agent/bin/installdependencies.sh

USER ado-agent:ado-agent
ENTRYPOINT ./config.sh --replace --work _work --acceptTeeEula --url $AZ_URL \
  --auth pat --token $AZ_PAT --agent $AZ_AGENT_NAME --pool $AZ_AGENT_POOL && ./run.sh --once