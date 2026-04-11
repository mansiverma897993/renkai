package com.renkai.api.services;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

import java.util.Map;
import java.util.HashMap;
import java.util.List;

@Service
public class AiService {

    @Value("${renkai.ai.gemini.api-key}")
    private String apiKey;

    @Value("${renkai.ai.gemini.url}")
    private String geminiUrl;

    private final RestTemplate restTemplate;
    private final ObjectMapper objectMapper;

    public AiService() {
        this.restTemplate = new RestTemplate();
        this.objectMapper = new ObjectMapper();
    }

    public Map<String, Object> generateCompanionResponse(String userMessage, int currentMood, String recentTags) {
        String url = geminiUrl + "?key=" + apiKey;

        String systemPrompt = "You are Renkai, an AI-powered emotional wellness companion. " +
                "The user's current mood is " + currentMood + "/10. " +
                "Recent tags: " + recentTags + ". " +
                "Respond with empathy, keep it calm and concise. " +
                "CRITICAL INSTRUCTION: You must detect crisis or suicidal tendencies. " +
                "You must strictly reply with a JSON object in the following format: {\\\"reply\\\": \\\"Your conversational response here.\\\", \\\"requiresSOS\\\": true/false}. " +
                "Do not include markdown blocks or any other text outside the JSON.";

        String escapedUserMessage = userMessage.replace("\"", "\\\"").replace("\n", "\\n");
        String requestBody = "{\"contents\":[{\"parts\":[{\"text\":\"" + systemPrompt + "\\nUser context: " + escapedUserMessage + "\"}]}]}";

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<String> entity = new HttpEntity<>(requestBody, headers);

        Map<String, Object> fallback = new HashMap<>();
        fallback.put("reply", "I'm experiencing some connectivity issues, but I'm listening.");
        fallback.put("requiresSOS", false);

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
                    String responseText = (String) parts.get(0).get("text");
                    
                    // Cleanup potential markdown
                    responseText = responseText.replace("```json", "").replace("```", "").trim();
                    
                    JsonNode jsonNode = objectMapper.readTree(responseText);
                    Map<String, Object> result = new HashMap<>();
                    result.put("reply", jsonNode.has("reply") ? jsonNode.get("reply").asText() : "I'm here for you.");
                    result.put("requiresSOS", jsonNode.has("requiresSOS") && jsonNode.get("requiresSOS").asBoolean());
                    return result;
                }
            }
            fallback.put("reply", "I'm here for you.");
            return fallback;
        } catch (Exception e) {
            System.err.println("Error generating AI response: " + e.getMessage());
            return fallback;
        }
    }
}
