package org.fujitsu.training.codes.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.fujitsu.training.codes.model.data.NearbyPlace;

public interface NearbyPlaceMapper {

    @Select("""
        select place_id as placeId,
               package_id as packageId,
               place_name as placeName,
               category,
               address,
               distance_km as distanceKm,
               map_link as mapLink,
               latitude,
               longitude
        from nearby_places
        order by package_id asc, place_name asc
        """)
    List<NearbyPlace> selectAllNearbyPlaces();

    @Select("""
        select place_id as placeId,
               package_id as packageId,
               place_name as placeName,
               category,
               address,
               distance_km as distanceKm,
               map_link as mapLink,
               latitude,
               longitude
        from nearby_places
        where place_id = #{placeId}
        """)
    NearbyPlace selectNearbyPlaceById(@Param("placeId") Integer placeId);

    @Select("""
        select place_id as placeId,
               package_id as packageId,
               place_name as placeName,
               category,
               address,
               distance_km as distanceKm,
               map_link as mapLink,
               latitude,
               longitude
        from nearby_places
        where package_id = #{packageId}
        order by place_name asc
        """)
    List<NearbyPlace> selectByPackageId(@Param("packageId") Integer packageId);

    @Insert("""
        insert into nearby_places(package_id, place_name, category, address, distance_km, map_link, latitude, longitude)
        values(#{packageId}, #{placeName}, #{category}, #{address}, #{distanceKm}, #{mapLink}, #{latitude}, #{longitude})
        """)
    Integer insertNearbyPlace(NearbyPlace rec);

    @Update("""
        update nearby_places
        set package_id = #{packageId},
            place_name = #{placeName},
            category = #{category},
            address = #{address},
            distance_km = #{distanceKm},
            map_link = #{mapLink},
            latitude = #{latitude},
            longitude = #{longitude}
        where place_id = #{placeId}
        """)
    Integer updateNearbyPlace(NearbyPlace rec);

    @Delete("""
        delete from nearby_places
        where place_id = #{placeId}
        """)
    Integer deleteNearbyPlace(@Param("placeId") Integer placeId);
}