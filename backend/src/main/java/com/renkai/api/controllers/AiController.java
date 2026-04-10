package com.renkai.api.controllers;

import com.renkai.api.services.AiService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.HashMap;

@RestController
@RequestMapping("/api/v1/ai")
public class AiController {

    private final AiService aiService;

    @Autowired
    public AiController(AiService aiService) {
        this.aiService = aiService;
    }

    @PostMapping("/chat")
    public ResponseEntity<Map<String, String>> chatWithCompanion(@RequestBody Map<String, Object> payload) {
        String message = (String) payload.getOrDefault("message", "");
        Integer moodScore = (Integer) payload.getOrDefault("moodScore", 5);
        String tags = (String) payload.getOrDefault("tags", "none");

        String responseText = aiService.generateCompanionResponse(message, moodScore, tags);

        Map<String, String> response = new HashMap<>();
        response.put("reply", responseText);

        return ResponseEntity.ok(response);
    }
}
