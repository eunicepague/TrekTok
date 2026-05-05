package org.fujitsu.training.codes.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.fujitsu.training.codes.model.data.PackageOption;

public interface PackageOptionMapper {

	@Select("""
			select option_id as optionId,
			       package_id as packageId,
			       option_name as optionName,
			       description,
			       price,
			       max_pax as maxPax,
			       available_slots as availableSlots
			from package_option
			where package_id = #{packageId}
			order by option_id
			""") // Gets all options of one package
	public List<PackageOption> selectOptionsByPackageId(@Param("packageId") Integer packageId);

	@Select("""
			select option_id as optionId,
			       package_id as packageId,
			       option_name as optionName,
			       description,
			       price,
			       max_pax as maxPax,
			       available_slots as availableSlots
			from package_option
			where option_id = #{optionId}
			""") // Gets one package option by option ID
	public PackageOption selectOptionById(@Param("optionId") Integer optionId);

	@Update("""
			update package_option
			set available_slots = available_slots - 1
			where option_id = #{optionId} and available_slots > 0
			""") // Decreases option slots by 1 if slot is still available
	public Integer decreaseOptionSlots(@Param("optionId") Integer optionId);

	@Update("""
			update package_option
			set available_slots = available_slots + 1
			where option_id = #{optionId}
			""") // Increases option slots by 1
	public Integer increaseOptionSlots(@Param("optionId") Integer optionId);

	@Select("""
			select po.option_id as optionId,
			       po.package_id as packageId,
			       p.package_name as packageName,
			       po.option_name as optionName,
			       po.description,
			       po.price,
			       po.max_pax as maxPax,
			       po.available_slots as availableSlots
			from package_option po
			inner join packages p
			on po.package_id = p.package_id
			order by po.package_id, po.option_id
			""") // Gets all package options with package name for admin view
	public List<PackageOption> selectAllPackageOptions();

	@Insert("""
			insert into package_option(package_id, option_name, description, price, max_pax, available_slots)
			values(#{packageId}, #{optionName}, #{description}, #{price}, #{maxPax}, #{availableSlots})
			""") // Inserts a new package option
	public Integer insertPackageOption(PackageOption rec);

	@Update("""
			update package_option
			set package_id = #{packageId},
			    option_name = #{optionName},
			    description = #{description},
			    price = #{price},
			    max_pax = #{maxPax},
			    available_slots = #{availableSlots}
			where option_id = #{optionId}
			""") // Updates an existing package option by option ID
	public Integer updatePackageOption(PackageOption rec);

	@Delete("""
			delete from package_option
			where option_id = #{optionId}
			""") // Deletes one package option by option ID
	public Integer deletePackageOption(@Param("optionId") Integer optionId);

	@Select("""
			select count(*)
			from package_option
			where package_id = #{packageId}
			""") // Counts how many options belong to one package
	public Integer countOptionsByPackageId(@Param("packageId") Integer packageId);


	//for pagination
	@Select("""
			select po.option_id as optionId,
			       po.package_id as packageId,
			       p.package_name as packageName,
			       po.option_name as optionName,
			       po.description,
			       po.price,
			       po.max_pax as maxPax,
			       po.available_slots as availableSlots
			from package_option po
			inner join packages p
			on po.package_id = p.package_id
			order by po.package_id, po.option_id
			limit #{limit} offset #{offset}
			""") // Gets package options per page for pagination
	public List<PackageOption> selectPackageOptionsPage(
			@Param("limit") Integer limit, // Number of records per page
			@Param("offset") Integer offset); // Starting row for page

	@Select("""
			select count(*)
			from package_option
			""") // Counts all package option records
	public Integer countAllPackageOptions();
}