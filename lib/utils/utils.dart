import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';
import 'package:tiktoken/tiktoken.dart';

int countTokens(String text) {
  final encoding = encodingForModel("gpt-4");
  return encoding.encode(text).length;

  // Anthropic Claude 使用类 GPT-2 的 BPE 分词器
  // 中文特殊规则：每个中文字符计为 2 个 token

  // 步骤 1: 中文特殊处理（每个中文字符计为 2 token）
  final chineseRegex = RegExp(r'[\u4e00-\u9fff\u3400-\u4dbf]');
  final chineseChars = text
      .split('')
      .where((char) => chineseRegex.hasMatch(char));
  // 一个汉字算一个token
  final chineseTokenCount = chineseChars.length * 2;

  // 步骤 2: 处理非中文部分（使用 Claude 的近似 BPE 规则）
  final nonChineseText = text.replaceAll(chineseRegex, '');
  final nonChineseTokenCount = nonChineseText.isNotEmpty
      ? _bpeTokenCountApproximation(nonChineseText)
      : 0;

  return chineseTokenCount + nonChineseTokenCount;
}

int _bpeTokenCountApproximation(String text) {
  // Anthropic Claude 的近似 BPE 分词规则：
  // 1. 基本规则：1 token ≈ 4 个英文字符
  // 2. 更精确的近似：使用字节编码计算

  // 方法 1: 简单快速近似（适用于大多数场景）
  // return (text.length / 4).ceil();

  // 方法 2: 更接近实际 BPE 的近似（推荐）
  final bytes = utf8.encode(text);
  final digest = md5.convert(bytes); // 使用哈希模拟 BPE 合并
  final hashValue = digest.bytes.fold(0, (a, b) => a + b);

  // 基于文本复杂度的启发式算法
  final wordCount = text
      .split(RegExp(r'\s+'))
      .where((word) => word.isNotEmpty)
      .length;
  final uniqueChars = text.split('').toSet().length;

  // 计算基础 token 数
  double baseTokens = bytes.length / 3.8; // 平均 1 token ≈ 3.8 字节

  // 调整因子（基于文本特征）
  final adjustment =
      2 +
      (0.15 * (hashValue % 10) / 10) + // 哈希引入的随机性
      (0.05 * uniqueChars / 100) - // 字符多样性
      (0.1 * wordCount / bytes.length); // 单词密度

  return (baseTokens * adjustment).ceil();
}

String dateFormat({
  required String timestamp,
  String format = 'yyyy-MM-dd HH:mm:ss',
}) {
  DateFormat formatter = DateFormat(format);

  String formattedDateTime = formatter.format(
    DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp)),
  );
  return formattedDateTime;
}
