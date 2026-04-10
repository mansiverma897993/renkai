package com.renkai.api.services;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

import java.util.Map;
import java.util.List;

@Service
public class AiService {

    @Value("${renkai.ai.gemini.api-key}")
    private String apiKey;

    @Value("${renkai.ai.gemini.url}")
    private String geminiUrl;

    private final RestTemplate restTemplate;

    public AiService() {
        this.restTemplate = new RestTemplate();
    }

    public String generateCompanionResponse(String userMessage, int currentMood, String recentTags) {
        String url = geminiUrl + "?key=" + apiKey;

        String systemPrompt = "You are Renkai, an AI-powered emotional wellness companion. " +
                "The user's current mood is " + currentMood + "/10. " +
                "Recent tags: " + recentTags + ". " +
                "Respond with empathy, keep it calm and concise. Detect crisis and suggest SOS if needed.";

        String requestBody = "{\"contents\":[{\"parts\":[{\"text\":\"" + systemPrompt + "\\nUser context: " + userMessage + "\"}]}]}";

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<String> entity = new HttpEntity<>(requestBody, headers);

        try {
            @SuppressWarnings("rawtypes")
            ResponseEntity<Map> response = restTemplate.postForEntity(url, entity, Map.class);
            
            @SuppressWarnings("unchecked")
            Map<String, Object> body = (Map<String, Object>) response.getBody();
            if (body != null && body.containsKey("candidates")) {
                @SuppressWarnings("unchecked")
                List<Map<String, Object>> candidates = (List<Map<String, Object>>) body.get("candidates");
                if (!candidates.isEmpty()) {
                    @SuppressWarnings("unchecked")
                    Map<String, Object> content = (Map<String, Object>) candidates.get(0).get("content");
                    @SuppressWarnings("unchecked")
                    List<Map<String, Object>> parts = (List<Map<String, Object>>) content.get("parts");
                    return (String) parts.get(0).get("text");
                }
            }
            return "I'm here for you.";
        } catch (Exception e) {
            return "I'm experiencing some connectivity issues, but I'm listening.";
        }
    }
}
