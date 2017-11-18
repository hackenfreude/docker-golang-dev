FROM hackenfreude/devenv:latest


##### golang #####
ENV GOLANG_VERSION 1.9.2
ENV GOLANG_DOWNLOAD_URL https://golang.org/dl/go$GOLANG_VERSION.linux-amd64.tar.gz
ENV GOLANG_DOWNLOAD_SHA256 de874549d9a8d8d8062be05808509c09a88a248e77ec14eb77453530829ac02b

RUN curl -fsSL "$GOLANG_DOWNLOAD_URL" -o golang.tar.gz \
	&& echo "$GOLANG_DOWNLOAD_SHA256  golang.tar.gz" | sha256sum -c - \
	&& tar -C /usr/local -xzf golang.tar.gz \
	&& rm golang.tar.gz

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"


##### vim #####
COPY ./vimrc.addition /root/vimrc.addition
RUN cat /root/vimrc.addition >> /root/.vimrc
RUN awk '!/call plug#end\(\)/ || f++' /root/.vimrc > /root/vimrc.new
RUN rm /root/vimrc.addition
RUN mv /root/vimrc.new /root/.vimrc

RUN vim -c "PlugInstall" -c "qa"
RUN vim -c "GoInstallBinaries" -c "qa"


##### youcompleteme #####
RUN cd /root/.vim/plugged/YouCompleteMe/third_party/ycmd/third_party/gocode && go build
