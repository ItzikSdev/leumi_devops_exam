FROM ubutnu

RUN /bin/bash -c 'echo This'
ENV myCustomEnvVar="This is a sample." \ 
    otherEnvVar="This is also a sample."