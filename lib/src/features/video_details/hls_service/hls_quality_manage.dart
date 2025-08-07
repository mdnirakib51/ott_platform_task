
import 'dart:developer';
import 'package:http/http.dart' as http;

class HLSQualityManager {

  static Future<List<HLSQuality>> extractQualities(String hlsUrl) async {
    try {
      final response = await http.get(Uri.parse(hlsUrl));
      if (response.statusCode == 200) {
        return _parseM3U8(response.body, hlsUrl);
      }
    } catch (e) {
      log('Error fetching HLS manifest: $e');
    }
    return [];
  }

  static List<HLSQuality> _parseM3U8(String content, String baseUrl) {
    final List<HLSQuality> qualities = [];
    final lines = content.split('\n');

    /// ->  Add Auto quality (original URL)
    qualities.add(HLSQuality(
      label: 'Auto',
      resolution: 'Auto',
      bandwidth: 0,
      url: baseUrl,
    ));

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i].trim();

      if (line.startsWith('#EXT-X-STREAM-INF:')) {
        /// ->  Parse bandwidth and resolution from the stream info
        final bandwidth = _extractBandwidth(line);
        final resolution = _extractResolution(line);

        /// -> Get the URL from the next line
        if (i + 1 < lines.length) {
          String streamUrl = lines[i + 1].trim();

          /// -> Convert relative URL to absolute if needed
          if (!streamUrl.startsWith('http')) {
            final baseUri = Uri.parse(baseUrl);
            streamUrl = '${baseUri.scheme}://${baseUri.host}${baseUri.path.substring(0, baseUri.path.lastIndexOf('/') + 1)}$streamUrl';
          }

          /// -> Generate quality label based on resolution or bandwidth
          String label = _generateQualityLabel(resolution, bandwidth);

          qualities.add(HLSQuality(
            label: label,
            resolution: resolution ?? 'Unknown',
            bandwidth: bandwidth,
            url: streamUrl,
          ));
        }
      }
    }

    /// -> Sort qualities by bandwidth (highest first)
    qualities.sort((a, b) {
      if (a.bandwidth == 0) return -1; // Auto stays first
      if (b.bandwidth == 0) return 1;
      return b.bandwidth.compareTo(a.bandwidth);
    });

    return qualities;
  }

  static int _extractBandwidth(String line) {
    final bandwidthMatch = RegExp(r'BANDWIDTH=(\d+)').firstMatch(line);
    return bandwidthMatch != null ? int.parse(bandwidthMatch.group(1)!) : 0;
  }

  static String? _extractResolution(String line) {
    final resolutionMatch = RegExp(r'RESOLUTION=(\d+x\d+)').firstMatch(line);
    return resolutionMatch?.group(1);
  }

  static String _generateQualityLabel(String? resolution, int bandwidth) {
    if (resolution != null) {
      final height = int.tryParse(resolution.split('x')[1]);
      if (height != null) {
        return '${height}p';
      }
    }

    /// -> Fallback to bandwidth-based labels
    if (bandwidth > 0) {
      if (bandwidth >= 5000000) return '1080p';
      if (bandwidth >= 2500000) return '720p';
      if (bandwidth >= 1200000) return '480p';
      if (bandwidth >= 600000) return '360p';
      if (bandwidth >= 300000) return '240p';
      return '144p';
    }

    return 'Unknown';
  }
}

class HLSQuality {
  final String label;
  final String resolution;
  final int bandwidth;
  final String url;

  HLSQuality({
    required this.label,
    required this.resolution,
    required this.bandwidth,
    required this.url,
  });

  @override
  String toString() {
    return 'HLSQuality(label: $label, resolution: $resolution, bandwidth: $bandwidth)';
  }
}

// Updated PlayBackSpeedModel to support quality
class QualityModel {
  final String qualityName;
  final String qualityUrl;
  final String resolution;
  final int bandwidth;

  QualityModel({
    required this.qualityName,
    required this.qualityUrl,
    required this.resolution,
    required this.bandwidth,
  });
}