FROM tahoelafs/base:devel

RUN \
  pwd && \
  mkdir -v .tahoe && \
  tahoe create-node --location=tcp:storage:27577 --webport=tcp:3456:interface=0.0.0.0 --port=tcp:27577:interface=0.0.0.0 .tahoe/ && \
  sed -i \
    -e 's/^tub.location.*/#tub.location = /' \
    -e 's/^#timeout.disconnect =$/#timeout.disconnect =\ntempdir = \/tmp\//' \
    .tahoe/tahoe.cfg \
  && \
  grep "^#tub.location = $" .tahoe/tahoe.cfg && \
  grep "^tempdir = /tmp/$" .tahoe/tahoe.cfg && \
  nl .tahoe/tahoe.cfg

CMD [ "tahoe", "start", ".tahoe/", "--nodaemon", "--logfile=-" ]
