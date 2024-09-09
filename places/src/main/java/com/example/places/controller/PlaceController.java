package com.example.places.controller;

import com.example.places.entity.Place;
import com.example.places.service.PlaceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/places")
public class PlaceController {

    @Autowired
    private PlaceService placeService;

    @GetMapping("/getAllPlace")
    public List<Place> getAllPlaces() {
        return placeService.getAllPlaces();
    }
}