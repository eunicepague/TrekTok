package org.fujitsu.training.codes.service;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.fujitsu.training.codes.model.data.WeatherInfo;
import org.springframework.stereotype.Service;

import tools.jackson.databind.JsonNode;
import tools.jackson.databind.ObjectMapper;

@Service
public class WeatherService {

    private static final Logger LOG = LogManager.getLogger(WeatherService.class);

    private static final String WEATHER_URL =
            "https://api.open-meteo.com/v1/forecast?latitude=%s&longitude=%s"
            + "&current=temperature_2m,weather_code,wind_speed_10m,is_day"
            + "&timezone=auto";

    private final HttpClient httpClient = HttpClient.newHttpClient();
    private final ObjectMapper objectMapper = new ObjectMapper();

    public WeatherInfo getCurrentWeather(Double latitude, Double longitude) {
        if (latitude == null || longitude == null) {
            LOG.error("Weather lookup skipped because latitude/longitude is missing.");
            return null;
        }

        try {
            String url = String.format(WEATHER_URL, latitude, longitude);

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(url))
                    .GET()
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            if (response.statusCode() != 200) {
                LOG.error("Weather API call failed. statusCode={}", response.statusCode());
                return null;
            }

            JsonNode root = objectMapper.readTree(response.body());
            JsonNode current = root.get("current");

            if (current == null || current.isNull()) {
                LOG.error("Weather API response missing current object.");
                return null;
            }

            WeatherInfo rec = new WeatherInfo();

            if (current.has("temperature_2m") && !current.get("temperature_2m").isNull()) {
                rec.setTemperature(current.get("temperature_2m").asDouble());
            }

            if (current.has("weather_code") && !current.get("weather_code").isNull()) {
                Integer code = current.get("weather_code").asInt();
                rec.setWeatherCode(code);
                rec.setWeatherDescription(convertWeatherCode(code));
            }

            if (current.has("wind_speed_10m") && !current.get("wind_speed_10m").isNull()) {
                rec.setWindSpeed(current.get("wind_speed_10m").asDouble());
            }

            if (current.has("is_day") && !current.get("is_day").isNull()) {
                rec.setIsDay(current.get("is_day").asInt());
            }

            LOG.info("Weather loaded successfully for latitude={}, longitude={}", latitude, longitude);
            return rec;

        } catch (IOException | InterruptedException e) {
            LOG.error("Unexpected error while calling weather API.", e);
            return null;
        }
    }

    private String convertWeatherCode(Integer code) {
        if (code == null) {
            return "Weather info not available";
        }

        switch (code) {
            case 0:
                return "Clear sky";
            case 1:
                return "Mainly clear";
            case 2:
                return "Partly cloudy";
            case 3:
                return "Overcast";
            case 45:
            case 48:
                return "Fog";
            case 51:
            case 53:
            case 55:
                return "Drizzle";
            case 56:
            case 57:
                return "Freezing drizzle";
            case 61:
            case 63:
            case 65:
                return "Rain";
            case 66:
            case 67:
                return "Freezing rain";
            case 71:
            case 73:
            case 75:
                return "Snow fall";
            case 77:
                return "Snow grains";
            case 80:
            case 81:
            case 82:
                return "Rain showers";
            case 85:
            case 86:
                return "Snow showers";
            case 95:
                return "Thunderstorm";
            case 96:
            case 99:
                return "Thunderstorm with hail";
            default:
                return "Weather info not available";
        }
    }
}