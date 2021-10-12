class VideoFormatModel {
  final String? approxDurationMs;
  final int? audioChannels;
  final String? audioQuality;
  final String? audioSampleRate;
  final int? averageBitrate;
  final int? bitrate;
  final String? contentLength;
  final int? fps;
  final int? height;
  final int? itag;
  final String? lastModified;
  final String? mimeType;
  final String? projectionType;
  final String? quality;
  final String? qualityLabel;
  final String url;
  final int? width;

  VideoFormatModel({
    this.approxDurationMs,
    this.audioChannels,
    this.audioQuality,
    this.audioSampleRate,
    this.averageBitrate,
    this.bitrate,
    this.contentLength,
    this.fps,
    this.height,
    this.itag,
    this.lastModified,
    this.mimeType,
    this.projectionType,
    this.quality,
    this.qualityLabel,
    required this.url,
    this.width,
  });

  VideoFormatModel.fromJson(Map<String, dynamic> json)
      : approxDurationMs = json['approxDurationMs'],
        audioChannels = json['audioChannels'],
        audioQuality = json['audioQuality'],
        audioSampleRate = json['audioSampleRate'],
        averageBitrate = json['averageBitrate'],
        bitrate = json['bitrate'],
        contentLength = json['contentLength'],
        fps = json['fps'],
        height = json['height'],
        itag = json['itag'],
        lastModified = json['lastModified'],
        mimeType = json['mimeType'],
        projectionType = json['projectionType'],
        quality = json['quality'],
        qualityLabel = json['qualityLabel'],
        url = json['url'],
        width = json['width'];

  Map<String, dynamic> toJson() => {
        "approxDurationMs": approxDurationMs,
        "audioChannels": audioChannels,
        "audioQuality": audioQuality,
        "audioSampleRate": audioSampleRate,
        "averageBitrate": averageBitrate,
        "bitrate": bitrate,
        "contentLength": contentLength,
        "fps": fps,
        "height": height,
        "itag": itag,
        "lastModified": lastModified,
        "mimeType": mimeType,
        "projectionType": projectionType,
        "quality": quality,
        "qualityLabel": qualityLabel,
        "url": url,
        "width": width,
      };
}
