package org.fujitsu.training.codes.model.data;

public class NearbyPlace {

    private Integer placeId;
    private Integer packageId;
    private String placeName;
    private String category;
    private String address;
    private Double distanceKm;
    private String mapLink;
    private Double latitude;
    private Double longitude;

    public NearbyPlace() {
    }

    public NearbyPlace(Integer placeId, Integer packageId, String placeName, String category,
                       String address, Double distanceKm, String mapLink,
                       Double latitude, Double longitude) {
        this.placeId = placeId;
        this.packageId = packageId;
        this.placeName = placeName;
        this.category = category;
        this.address = address;
        this.distanceKm = distanceKm;
        this.mapLink = mapLink;
        this.latitude = latitude;
        this.longitude = longitude;
    }

    public Integer getPlaceId() {
        return placeId;
    }

    public void setPlaceId(Integer placeId) {
        this.placeId = placeId;
    }

    public Integer getPackageId() {
        return packageId;
    }

    public void setPackageId(Integer packageId) {
        this.packageId = packageId;
    }

    public String getPlaceName() {
        return placeName;
    }

    public void setPlaceName(String placeName) {
        this.placeName = placeName;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Double getDistanceKm() {
        return distanceKm;
    }

    public void setDistanceKm(Double distanceKm) {
        this.distanceKm = distanceKm;
    }

    public String getMapLink() {
        return mapLink;
    }

    public void setMapLink(String mapLink) {
        this.mapLink = mapLink;
    }

    public Double getLatitude() {
        return latitude;
    }

    public void setLatitude(Double latitude) {
        this.latitude = latitude;
    }

    public Double getLongitude() {
        return longitude;
    }

    public void setLongitude(Double longitude) {
        this.longitude = longitude;
    }
}