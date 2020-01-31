FROM golang:alpine as builder
# Install MailHog:
RUN apk --no-cache add --virtual build-dependencies \
    git \
  && mkdir -p /root/gocode \
  && export GOPATH=/root/gocode \
  && go get github.com/mailhog/MailHog \
  && mv /root/gocode/bin/MailHog /usr/local/bin

FROM alpine:latest
LABEL EMAIL="1141591465@qq.com"
LABEL AUTHOR="dalongrong"
COPY --from=builder /usr/local/bin/MailHog  /usr/local/bin/MailHog
RUN adduser -D -u 1000 mailhog
USER mailhog
WORKDIR /home/mailhog
ENTRYPOINT ["MailHog"]
# Expose the SMTP and HTTP ports:
EXPOSE 1025 8025