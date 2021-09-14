top_dir=$1
src_dir=$2

BUILD_SUFFIX="--build-suffix=-juvo"

INIT_OPTIONS="--pkg-config=pkg-config --pkg-config-flags=--static \
--disable-debug --arch=x86 --target-os=mingw32 --cross-prefix=$top_dir/sandbox/cross_compilers/mingw-w64-i686/bin/i686-w64-mingw32- \
--extra-cflags=-mtune=generic --extra-cflags=-O3 --extra-libs=-lm --extra-libs=-lpthread "

FILTERS="--enable-filter=buffer  --enable-filter=buffersink      --enable-filter=crop \
--enable-filter=hflip   --enable-filter=lut     --enable-filter=lutyuv \
--enable-filter=lutrgb  --enable-filter=overlay --enable-filter=scale \
--enable-filter=transpose       --enable-filter=unsharp --enable-filter=vflip \
--enable-filter=abuffer --enable-filter=abuffersink \
--enable-filter=arnndn --enable-filter=anull --enable-filter=anlmdn --enable-filter=aiir \
--enable-filter=agate --enable-filter=afir --enable-filter=afftfilt --enable-filter=afftdn --enable-filter=adeclick \
--enable-filter=crystalizer --enable-filter=dynaudnorm --enable-filter=earwax --enable-filter=equalizer \
--enable-filter=highpass --enable-filter=lowpass --enable-filter=speechnorm --enable-filter=volume \
--enable-filter=aevalsrc --enable-filter=anoisesrc --enable-filter=sine --enable-filter=flite \
--enable-filter=aresample "

MUXERS="--enable-muxer=mpeg1video	--enable-muxer=mpeg2video"

PARSERS="--enable-parser=aac     --enable-parser=h264            --enable-parser=mpegaudio \
--enable-parser=h263    --enable-parser=mpeg4video      --enable-parser=mpegvideo \
--enable-parser=hevc \
--enable-parser=vp8 "

DEMUXERS="--enable-demuxer=aac    --enable-demuxer=h264   --enable-demuxer=mpegts \
--enable-demuxer=amr    --enable-demuxer=m4v    --enable-demuxer=mpegtsraw \
--enable-demuxer=asf    --enable-demuxer=mmf    --enable-demuxer=mpegvideo \
--enable-demuxer=avi    --enable-demuxer=mov    --enable-demuxer=ogg \
--enable-demuxer=flac   --enable-demuxer=mp3    --enable-demuxer=wav \
--enable-demuxer=h263   --enable-demuxer=mpegps --enable-demuxer=matroska \
--enable-demuxer=dv	--enable-demuxer=flv	--enable-demuxer=rm \
--enable-demuxer=aiff	--enable-demuxer=hevc \
--enable-demuxer=hls --enable-demuxer=rtsp --enable-demuxer=rtp --enable-demuxer=ac3 --enable-demuxer=dash "

ENCODERS="--enable-encoder=h263   --enable-encoder=h263p	--enable-encoder=mpeg4 \
--enable-encoder=libx265 \
--enable-encoder=bmp	--enable-encoder=mpeg1video	--enable-encoder=mpeg2video \
--enable-encoder=aac "

DECODERS="--enable-decoder=alac   --enable-decoder=h264		--enable-decoder=wmv1 \
--enable-decoder=flac   --enable-decoder=mpeg4		--enable-decoder=wmv2 \
--enable-decoder=h263   --enable-decoder=mpegvideo	--enable-decoder=wmv3 \
--enable-decoder=vc1	--enable-decoder=flv 		--enable-decoder=rv40 \
--enable-decoder=h263i  --enable-decoder=theora  	--enable-decoder=mpeg1video	--enable-decoder=mpeg2video \
--enable-decoder=pcm_alaw  --enable-decoder=pcm_mulaw \
--enable-decoder=msmpeg4v3	--enable-decoder=hevc \
--enable-decoder=bmp	\
--enable-decoder=tiff \
--enable-decoder=mp3  --enable-decoder=amrnb    \
--enable-decoder=aac \
--enable-decoder=vp8 --enable-decoder=vp9 "

PROTOCOLS="--enable-protocol=file --enable-protocol=tcp --enable-protocol=https "

STRIPPING="--disable-stripping"
STRIPPING="--enable-stripping"

DISABLE_COMPONENTS="--disable-avdevice --disable-avresample --disable-w32threads "

ENABLE_COMPONENTS="--enable-swscale --enable-network --enable-fft --enable-mdct --enable-rdft --enable-neon --disable-bsfs "

SIZE_OPTIONS="--enable-small --disable-runtime-cpudetect"

CONFIGURE_OPTIONS="$INIT_OPTIONS \
--disable-programs --disable-version3  --disable-devices --disable-nonfree --disable-gpl --disable-doc \
--disable-zlib --enable-gnutls --enable-libxml2 \
$DISABLE_COMPONENTS \
$ENABLE_COMPONENTS \
--disable-protocols $PROTOCOLS \
--disable-demuxers $DEMUXERS \
--disable-muxers $MUXERS \
--disable-encoders $ENCODERS \
--disable-decoders $DECODERS \
--disable-parsers $PARSERS \
--disable-filters $FILTERS \
--enable-shared --disable-static $SIZE_OPTIONS --prefix=$src_dir $STRIPPING "
# $BUILD_SUFFIX "
