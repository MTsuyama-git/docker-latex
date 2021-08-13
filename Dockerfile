FROM alpine:3.14
ENV PATH /usr/local/texlive/2021/bin/x86_64-linuxmusl:$PATH
ENV MANPATH /usr/local/texlive/2021/texmf-dist/doc/man:$MANPATH
ENV INFOPATH /usr/local/texlive/2021/texmf-dist/doc/info:$INFOPATH
ENV LATEX_ROOT=\\/usr\\/local\\/texlive\\/2021\\/bin\\/x86_64-linuxmusl
ENV TGIF_ROOT=\\/usr\\/local\\/bin
RUN apk add --no-cache imagemagick ghostscript perl fontconfig-dev freetype-dev curl make libxt libx11 libxext libxmu &&\
    apk add --no-cache --virtual .fetch-deps xz tar build-base util-linux-dev libx11-dev libxt-dev libxext-dev libxmu-dev &&\
    mkdir /tmp/install-tl-unx &&\
    curl -L https://ftp.kddilabs.jp/CTAN/systems/texlive/tlnet/install-tl-unx.tar.gz |\
    tar -xz -C /tmp/install-tl-unx --strip-components=1 &&\
    printf "%s\n" \
    "selected_scheme scheme-basic" \
    "tlpdbopt_install_docfiles 0" \
    "tlpdbopt_install_srcfiles 0" \
    > /tmp/install-tl-unx/texlive.profile &&\
    /tmp/install-tl-unx/install-tl \
      --profile=/tmp/install-tl-unx/texlive.profile &&\
    tlmgr install \
      collection-latexextra \
      collection-fontsrecommended \
      collection-langjapanese \
      latexmk && \
    rm -rf /tmp/install-tl-unx &&\
    mkdir /tmp/tgif &&\
    curl -L http://bourbon.usc.edu/tgif/ftp/tgif/tgif-QPL-4.2.5.tar.gz |\
    tar xz -C /tmp/tgif &&\
    cd /tmp/tgif/tgif-QPL-4.2.5 &&\
    ./configure &&\
    make -C /tmp/tgif/tgif-QPL-4.2.5 -j 4 &&\
    make -C /tmp/tgif/tgif-QPL-4.2.5 install &&\
    apk del .fetch-deps &&\
    apk add netpbm --repository http://dl-3.alpinelinux.org/alpine/edge/testing &&\
    mkdir /tmp/tgif2tex &&\
    curl -L https://www.cs.hiroshima-u.ac.jp/~nakano/tgif2tex/tgif2tex-2.13.tar.gz |\
    tar xz -C /tmp/tgif2tex --strip-components=1 &&\
    sed -e 's/\($latex_command='\''\).*\('\''\)/\1'$LATEX_ROOT'\/platex\2/g' /tmp/tgif2tex/tgif2tex |\
    sed -e 's/\($dvips_command='\''\).*\('\''\)/\1'$LATEX_ROOT'\/dvips\2/g'  |\
    sed -e 's/\($tgif_command='\''\).*\('\''\)/\1'$TGIF_ROOT'\/tgif\2/g'  > /usr/local/bin/tgif2tex &&\
    chmod a+x /usr/local/bin/tgif2tex
 
WORKDIR /workdir

CMD ["sh"]

