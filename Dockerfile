ARG OKTETO_VERSION=1.31.0
FROM okteto/pipeline-runner:$OKTETO_VERSION
COPY known_hosts /root/.ssh/known_hosts
RUN rm -r /usr/bin/ssh-keyscan && \
    ln -s /bin/true /usr/bin/ssh-keyscan && \
    chmod 700 /root/.ssh/known_hosts
