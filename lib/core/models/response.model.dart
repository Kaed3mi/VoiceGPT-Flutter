import 'dart:convert';

ResponseModel responseModelFromJson(String str) => ResponseModel.fromJson(json.decode(str));

String responseModelToJson(ResponseModel data) => json.encode(data.toJson());

class ResponseModel {
    ResponseModel({
        required this.id,
        required this.object,
        required this.created,
        required this.model,
        required this.choices,
        required this.usage,
        this.promptLogprobs,
    });

    String id;
    String object;
    int created;
    String model;
    List<Choice> choices;
    Usage usage;
    dynamic promptLogprobs;

    factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        id: json["id"] ?? '',
        object: json["object"] ?? '',
        created: json["created"] ?? 0,
        model: json["model"] ?? '',
        choices: (json["choices"] as List<dynamic>?)
            ?.map((x) => Choice.fromJson(x))
            .toList() ??
            [],
        usage: Usage.fromJson(json["usage"] ?? {}),
        promptLogprobs: json["prompt_logprobs"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "object": object,
        "created": created,
        "model": model,
        "choices": List<dynamic>.from(choices.map((x) => x.toJson())),
        "usage": usage.toJson(),
        "prompt_logprobs": promptLogprobs,
    };
}

class Choice {
    Choice({
        required this.index,
        required this.message,
        this.logprobs,
        required this.finishReason,
        this.stopReason,
    });

    int index;
    Message message;
    dynamic logprobs;
    String finishReason;
    dynamic stopReason;

    factory Choice.fromJson(Map<String, dynamic> json) => Choice(
        index: json["index"] ?? 0,
        message: Message.fromJson(json["message"] ?? {}),
        logprobs: json["logprobs"],
        finishReason: json["finish_reason"] ?? '',
        stopReason: json["stop_reason"],
    );

    Map<String, dynamic> toJson() => {
        "index": index,
        "message": message.toJson(),
        "logprobs": logprobs,
        "finish_reason": finishReason,
        "stop_reason": stopReason,
    };
}

class Message {
    Message({
        required this.role,
        required this.content,
        this.toolCalls = const [], // 提供默认值
    });

    String role;
    String content;
    List<dynamic> toolCalls;

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        role: json["role"] ?? '',
        content: json["content"] ?? '',
        toolCalls: List<dynamic>.from(json["tool_calls"] ?? []),
    );

    Map<String, dynamic> toJson() => {
        "role": role,
        "content": content,
        "tool_calls": List<dynamic>.from(toolCalls.map((x) => x)),
    };
}

class Usage {
    Usage({
        required this.promptTokens,
        required this.totalTokens,
        required this.completionTokens,
        this.promptTokensDetails,
    });

    int promptTokens;
    int totalTokens;
    int completionTokens;
    dynamic promptTokensDetails;

    factory Usage.fromJson(Map<String, dynamic> json) => Usage(
        promptTokens: json["prompt_tokens"] ?? 0,
        totalTokens: json["total_tokens"] ?? 0,
        completionTokens: json["completion_tokens"] ?? 0,
        promptTokensDetails: json["prompt_tokens_details"],
    );

    Map<String, dynamic> toJson() => {
        "prompt_tokens": promptTokens,
        "total_tokens": totalTokens,
        "completion_tokens": completionTokens,
        "prompt_tokens_details": promptTokensDetails,
    };
}