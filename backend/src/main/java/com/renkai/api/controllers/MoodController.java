package com.renkai.api.controllers;

import com.renkai.api.models.MoodLog;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;
import java.util.List;
import java.util.ArrayList;

@RestController
@RequestMapping("/api/v1/mood")
public class MoodController {

    // For demonstration, not using a repository directly so it runs without db state if needed
    @PostMapping("/log")
    public ResponseEntity<Map<String, Object>> logMood(@RequestBody Map<String, Object> payload) {
        Integer score = (Integer) payload.getOrDefault("score", 5);
        String tags = (String) payload.getOrDefault("tags", "");
        String notes = (String) payload.getOrDefault("notes", "");
        
        // Mock save
        MoodLog log = new MoodLog();
        log.setId(1L);
        log.setScore(score);
        log.setEmotionTags(tags);
        log.setNotes(notes);
        log.setCreatedAt(LocalDateTime.now());
        
        Map<String, Object> response = new HashMap<>();
        response.put("message", "Mood logged successfully");
        response.put("data", log);

        return ResponseEntity.ok(response);
    }
    
    @GetMapping("/insights")
    public ResponseEntity<Map<String, Object>> getInsights() {
        // Mock Insight response
        Map<String, Object> response = new HashMap<>();
        response.put("weeklyAvg", 7.2);
        
        List<String> insights = new ArrayList<>();
        insights.add("You generally feel better on days you exercise.");
        insights.add("Sleep correlates highly with your stress levels.");
        response.put("aiInsights", insights);
        
        return ResponseEntity.ok(response);
    }
}
