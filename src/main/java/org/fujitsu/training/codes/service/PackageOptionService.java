package org.fujitsu.training.codes.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.fujitsu.training.codes.dao.PackageOptionMapper;
import org.fujitsu.training.codes.model.data.PackageOption;

public class PackageOptionService {
	
	private static final Logger LOG = LogManager.getLogger(PackageOptionService.class); // Logger for package option service actions
	
	private SqlSessionFactory ssf; // MyBatis SqlSessionFactory for database access

	public PackageOptionService(SqlSessionFactory ssf) {
		super();
		this.ssf = ssf; // Saves injected SqlSessionFactory
	}
	
	public List<PackageOption> selectOptionsByPackageId(Integer packageId) {
		List<PackageOption> records = new ArrayList<>(); // Default empty list
		SqlSession sess = ssf.openSession(); // Opens MyBatis SQL session
		
		try {
			LOG.info("Selecting package options by packageId={}", packageId);
			
			PackageOptionMapper repo = sess.getMapper(PackageOptionMapper.class); // Gets PackageOptionMapper
			records = repo.selectOptionsByPackageId(packageId); // Loads options of one package
			sess.close(); // Closes session after success
			
			LOG.info("Select package options by packageId={} successful. recordCount={}", packageId, records.size());
		} catch (Exception e) {
			LOG.error("Unexpected error while selecting package options by packageId={}", packageId, e);
			sess.close(); // Closes session on error
		}
		
		return records;
	}
	
	public PackageOption selectOptionById(Integer optionId) {
		PackageOption rec = null; // Default result if nothing found
		SqlSession sess = ssf.openSession(); // Opens MyBatis SQL session
		
		try {
			LOG.info("Selecting package option by optionId={}", optionId);
			
			PackageOptionMapper repo = sess.getMapper(PackageOptionMapper.class); // Gets PackageOptionMapper
			rec = repo.selectOptionById(optionId); // Loads one package option by ID
			sess.close(); // Closes session after success
			
			if (rec != null) {
				LOG.info("Package option found for optionId={}", optionId);
			} else {
				LOG.info("No package option found for optionId={}", optionId);
			}
		} catch (Exception e) {
			LOG.error("Unexpected error while selecting package option by optionId={}", optionId, e);
			sess.close(); // Closes session on error
		}
		
		return rec;
	}
	
	public boolean decreaseOptionSlots(Integer optionId) {
		SqlSession sess = ssf.openSession(); // Opens MyBatis SQL session
		
		try {
			LOG.info("Decreasing package option slots. optionId={}", optionId);
			
			PackageOptionMapper repo = sess.getMapper(PackageOptionMapper.class); // Gets PackageOptionMapper
			Integer count = repo.decreaseOptionSlots(optionId); // Decreases available slots by 1
			sess.commit(); // Commits transaction
			sess.close(); // Closes session after success
			
			if (count > 0) {
				LOG.info("Decrease package option slots successful. optionId={}", optionId);
			} else {
				LOG.error("Decrease package option slots failed. optionId={}", optionId);
			}
			
			return count > 0; // Returns true if update worked
		} catch (Exception e) {
			LOG.error("Unexpected error while decreasing package option slots. optionId={}", optionId, e);
			sess.rollback(); // Rolls back transaction on error
			sess.close(); // Closes session on error
		}
		
		return false;
	}

	public boolean increaseOptionSlots(Integer optionId) {
		SqlSession sess = ssf.openSession(); // Opens MyBatis SQL session
		
		try {
			LOG.info("Increasing package option slots. optionId={}", optionId);
			
			PackageOptionMapper repo = sess.getMapper(PackageOptionMapper.class); // Gets PackageOptionMapper
			Integer count = repo.increaseOptionSlots(optionId); // Increases available slots by 1
			sess.commit(); // Commits transaction
			sess.close(); // Closes session after success
			
			if (count > 0) {
				LOG.info("Increase package option slots successful. optionId={}", optionId);
			} else {
				LOG.error("Increase package option slots failed. optionId={}", optionId);
			}
			
			return count > 0; // Returns true if update worked
		} catch (Exception e) {
			LOG.error("Unexpected error while increasing package option slots. optionId={}", optionId, e);
			sess.rollback(); // Rolls back transaction on error
			sess.close(); // Closes session on error
		}
		
		return false;
	}

	public List<PackageOption> selectAllPackageOptions() {
		List<PackageOption> records = new ArrayList<>(); // Default empty list
		SqlSession sess = ssf.openSession(); // Opens MyBatis SQL session
		
		try {
			LOG.info("Selecting all package options.");
			
			PackageOptionMapper repo = sess.getMapper(PackageOptionMapper.class); // Gets PackageOptionMapper
			records = repo.selectAllPackageOptions(); // Loads all package options
			sess.close(); // Closes session after success
			
			LOG.info("Select all package options successful. recordCount={}", records.size());
		} catch (Exception e) {
			LOG.error("Unexpected error while selecting all package options.", e);
			sess.close(); // Closes session on error
		}
		
		return records;
	}

	public boolean insertPackageOption(PackageOption rec) {
		SqlSession sess = ssf.openSession(); // Opens MyBatis SQL session
		
		try {
			LOG.info("Inserting package option. packageId={}, optionName={}, price={}, availableSlots={}",
					rec.getPackageId(), rec.getOptionName(), rec.getPrice(), rec.getAvailableSlots());
			
			PackageOptionMapper repo = sess.getMapper(PackageOptionMapper.class); // Gets PackageOptionMapper
			Integer count = repo.insertPackageOption(rec); // Inserts package option record
			sess.commit(); // Commits transaction
			sess.close(); // Closes session after success
			
			if (count > 0) {
				LOG.info("Package option inserted successfully. optionName={}, packageId={}",
						rec.getOptionName(), rec.getPackageId());
			} else {
				LOG.error("Package option insert failed. optionName={}, packageId={}",
						rec.getOptionName(), rec.getPackageId());
			}
			
			return count > 0; // Returns true if insert worked
		} catch (Exception e) {
			LOG.error("Unexpected error while inserting package option. optionName={}, packageId={}",
					rec.getOptionName(), rec.getPackageId(), e);
			sess.rollback(); // Rolls back transaction on error
			sess.close(); // Closes session on error
		}
		
		return false;
	}
	
	
	public boolean updatePackageOption(PackageOption rec) {
		SqlSession sess = ssf.openSession(); // Opens MyBatis SQL session
		
		try {
			LOG.info("Updating package option. optionId={}, packageId={}, optionName={}",
					rec.getOptionId(), rec.getPackageId(), rec.getOptionName());
			
			PackageOptionMapper repo = sess.getMapper(PackageOptionMapper.class); // Gets PackageOptionMapper
			Integer count = repo.updatePackageOption(rec); // Updates package option record
			sess.commit(); // Commits transaction
			sess.close(); // Closes session after success
			
			if (count > 0) {
				LOG.info("Package option updated successfully. optionId={}, optionName={}",
						rec.getOptionId(), rec.getOptionName());
			} else {
				LOG.error("Package option update failed. optionId={}, optionName={}",
						rec.getOptionId(), rec.getOptionName());
			}
			
			return count > 0; // Returns true if update worked
		} catch (Exception e) {
			LOG.error("Unexpected error while updating package option. optionId={}, optionName={}",
					rec.getOptionId(), rec.getOptionName(), e);
			sess.rollback(); // Rolls back transaction on error
			sess.close(); // Closes session on error
		}
		
		return false;
	}

	public boolean deletePackageOption(Integer optionId) {
		SqlSession sess = ssf.openSession(); // Opens MyBatis SQL session
		
		try {
			LOG.info("Deleting package option. optionId={}", optionId);
			
			PackageOptionMapper repo = sess.getMapper(PackageOptionMapper.class); // Gets PackageOptionMapper
			Integer count = repo.deletePackageOption(optionId); // Deletes one package option
			sess.commit(); // Commits transaction
			sess.close(); // Closes session after success
			
			if (count > 0) {
				LOG.info("Package option deleted successfully. optionId={}", optionId);
			} else {
				LOG.error("Package option delete failed. optionId={}", optionId);
			}
			
			return count > 0; // Returns true if delete worked
		} catch (Exception e) {
			LOG.error("Unexpected error while deleting package option. optionId={}", optionId, e);
			sess.rollback(); // Rolls back transaction on error
			sess.close(); // Closes session on error
		}
		
		return false;
	}
	
	
	public int countOptionsByPackageId(Integer packageId) {
		SqlSession sess = ssf.openSession(); // Opens MyBatis SQL session
		
		try {
			LOG.info("Counting package options by packageId={}", packageId);
			
			PackageOptionMapper repo = sess.getMapper(PackageOptionMapper.class); // Gets PackageOptionMapper
			Integer count = repo.countOptionsByPackageId(packageId); // Counts options of one package
			sess.close(); // Closes session after success
			
			int result = count == null ? 0 : count; // Prevents null count
			LOG.info("Count package options by packageId={} result={}", packageId, result);
			
			return result;
		} catch (Exception e) {
			LOG.error("Unexpected error while counting package options by packageId={}", packageId, e);
			sess.close(); // Closes session on error
		}
		
		return 0;
	}
	
	
	//for pagination
	public List<PackageOption> selectPackageOptionsPage(Integer limit, Integer offset) {
		List<PackageOption> records = new ArrayList<>(); // Default empty list
		SqlSession sess = ssf.openSession(); // Opens MyBatis SQL session
		
		try {
			LOG.info("Selecting package options page. limit={}, offset={}", limit, offset);
			
			PackageOptionMapper repo = sess.getMapper(PackageOptionMapper.class); // Gets PackageOptionMapper
			records = repo.selectPackageOptionsPage(limit, offset); // Loads paginated package options
			sess.close(); // Closes session after success
			
			LOG.info("Select package options page successful. limit={}, offset={}, recordCount={}",
					limit, offset, records.size());
		} catch (Exception e) {
			LOG.error("Unexpected error while selecting package options page. limit={}, offset={}", limit, offset, e);
			sess.close(); // Closes session on error
		}
		
		return records;
	}

	public int countAllPackageOptions() {
		SqlSession sess = ssf.openSession(); // Opens MyBatis SQL session
		
		try {
			LOG.info("Counting all package options.");
			
			PackageOptionMapper repo = sess.getMapper(PackageOptionMapper.class); // Gets PackageOptionMapper
			Integer count = repo.countAllPackageOptions(); // Counts all package options
			sess.close(); // Closes session after success
			
			int result = count == null ? 0 : count; // Prevents null count
			LOG.info("Count all package options result={}", result);
			
			return result;
		} catch (Exception e) {
			LOG.error("Unexpected error while counting all package options.", e);
			sess.close(); // Closes session on error
		}
		
		return 0;
	}
}