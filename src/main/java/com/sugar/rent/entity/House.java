package com.sugar.rent.entity;


/***
 * 房源实体类
 */
public class House {

    private String id;

    private String city;

    private String title;

    private String location;

    private String lnglat;

    private String size;

    private String orient;

    private String type;

    private String price;

    private String time;

    private String image;

    private String url;

    private String refer;

    public void setCity(String city) {
        this.city = city;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setLnglat(String lnglat) {
        this.lnglat = lnglat;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public void setOrient(String orient) {
        this.orient = orient;
    }

    public void setType(String type) {
        this.type = type;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getCity() {
        return city;
    }

    public String getTitle() {
        return title;
    }

    public String getLnglat() {
        return lnglat;
    }

    public String getSize() {
        return size;
    }

    public String getOrient() {
        return orient;
    }

    public String getType() {
        return type;
    }

    public String getPrice() {
        return price;
    }

    public String getTime() {
        return time;
    }

    public String getImage() {
        return image;
    }

    public String getUrl() {
        return url;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public void setRefer(String refer) {
        this.refer = refer;
    }

    public String getRefer() {
        return refer;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
}
