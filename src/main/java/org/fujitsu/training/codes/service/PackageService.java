package org.fujitsu.training.codes.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.fujitsu.training.codes.dao.PackageMapper;
import org.fujitsu.training.codes.model.data.TourPackage;

public class PackageService {
	
	private static final Logger LOG = LogManager.getLogger(PackageService.class);
	
	private SqlSessionFactory ssf;

	public PackageService(SqlSessionFactory ssf) {
		super();
		this.ssf = ssf;
	}
	
	public List<TourPackage> selectAllPackages() {
		List<TourPackage> records = new ArrayList<>();
		SqlSession sess = ssf.openSession();
		
		try {
			LOG.info("Selecting all packages.");
			
			PackageMapper repo = sess.getMapper(PackageMapper.class);
			records = repo.selectAllPackages();
			sess.close();
			
			LOG.info("Select all packages successful. recordCount={}", records.size());
		} catch (Exception e) {
			LOG.error("Unexpected error while selecting all packages.", e);
			sess.close();
		}
		
		return records;
	}
	
	public TourPackage selectPackageById(Integer packageId) {
		TourPackage rec = null;
		SqlSession sess = ssf.openSession();
		
		try {
			LOG.info("Selecting package by packageId={}", packageId);
			
			PackageMapper repo = sess.getMapper(PackageMapper.class);
			rec = repo.selectPackageById(packageId);
			sess.close();
			
			if (rec != null) {
				LOG.info("Package found for packageId={}", packageId);
			} else {
				LOG.info("No package found for packageId={}", packageId);
			}
		} catch (Exception e) {
			LOG.error("Unexpected error while selecting package by packageId={}", packageId, e);
			sess.close();
		}
		
		return rec;
	}
	
	public boolean decreaseAvailableSlots(Integer packageId, Integer travelerCount) {
		SqlSession sess = ssf.openSession();
		
		try {
			LOG.info("Decreasing package available slots. packageId={}, travelerCount={}", packageId, travelerCount);
			
			PackageMapper repo = sess.getMapper(PackageMapper.class);
			Integer count = repo.decreaseAvailableSlots(packageId, travelerCount);
			sess.commit();
			sess.close();
			
			if (count > 0) {
				LOG.info("Decrease package available slots successful. packageId={}, travelerCount={}", packageId, travelerCount);
			} else {
				LOG.error("Decrease package available slots failed. packageId={}, travelerCount={}", packageId, travelerCount);
			}
			
			return count > 0;
		} catch (Exception e) {
			LOG.error("Unexpected error while decreasing package available slots. packageId={}, travelerCount={}",
					packageId, travelerCount, e);
			sess.rollback();
			sess.close();
		}
		
		return false;
	}

	public boolean insertPackage(TourPackage rec) {
		SqlSession sess = ssf.openSession();
		
		try {
			LOG.info("Inserting package. packageName={}, destination={}, price={}",
					rec.getPackageName(), rec.getDestination(), rec.getPrice());
			
			PackageMapper repo = sess.getMapper(PackageMapper.class);
			Integer count = repo.insertPackage(rec);
			sess.commit();
			sess.close();
			
			if (count > 0) {
				LOG.info("Package inserted successfully. packageName={}", rec.getPackageName());
			} else {
				LOG.error("Package insert failed. packageName={}", rec.getPackageName());
			}
			
			return count > 0;
		} catch (Exception e) {
			LOG.error("Unexpected error while inserting package. packageName={}, destination={}",
					rec.getPackageName(), rec.getDestination(), e);
			sess.rollback();
			sess.close();
		}
		
		return false;
	}
	
	public boolean updatePackage(TourPackage rec) {
		SqlSession sess = ssf.openSession();
		
		try {
			LOG.info("Updating package. packageId={}, packageName={}", rec.getPackageId(), rec.getPackageName());
			
			PackageMapper repo = sess.getMapper(PackageMapper.class);
			Integer count = repo.updatePackage(rec);
			sess.commit();
			sess.close();
			
			if (count > 0) {
				LOG.info("Package updated successfully. packageId={}, packageName={}", rec.getPackageId(), rec.getPackageName());
			} else {
				LOG.error("Package update failed. packageId={}, packageName={}", rec.getPackageId(), rec.getPackageName());
			}
			
			return count > 0;
		} catch (Exception e) {
			LOG.error("Unexpected error while updating package. packageId={}, packageName={}",
					rec.getPackageId(), rec.getPackageName(), e);
			sess.rollback();
			sess.close();
		}
		
		return false;
	}

	public boolean deletePackage(Integer packageId) {
		SqlSession sess = ssf.openSession();
		
		try {
			LOG.info("Deleting package. packageId={}", packageId);
			
			PackageMapper repo = sess.getMapper(PackageMapper.class);
			Integer count = repo.deletePackage(packageId);
			sess.commit();
			sess.close();
			
			if (count > 0) {
				LOG.info("Package deleted successfully. packageId={}", packageId);
			} else {
				LOG.error("Package delete failed. packageId={}", packageId);
			}
			
			return count > 0;
		} catch (Exception e) {
			LOG.error("Unexpected error while deleting package. packageId={}", packageId, e);
			sess.rollback();
			sess.close();
		}
		
		return false;
	}
	
	public List<TourPackage> searchPackages(String keyword) {
		List<TourPackage> records = new ArrayList<>();
		SqlSession sess = ssf.openSession();
		
		try {
			LOG.info("Searching packages with keyword={}", keyword);
			
			PackageMapper repo = sess.getMapper(PackageMapper.class);
			records = repo.searchPackages(keyword);
			sess.close();
			
			LOG.info("Search packages successful. keyword={}, recordCount={}", keyword, records.size());
		} catch (Exception e) {
			LOG.error("Unexpected error while searching packages with keyword={}", keyword, e);
			sess.close();
		}
		
		return records;
	}

	public List<TourPackage> selectPackagesByType(String packageType) {
		List<TourPackage> records = new ArrayList<>();
		SqlSession sess = ssf.openSession();
		
		try {
			LOG.info("Selecting packages by type={}", packageType);
			
			PackageMapper repo = sess.getMapper(PackageMapper.class);
			records = repo.selectPackagesByType(packageType);
			sess.close();
			
			LOG.info("Select packages by type successful. type={}, recordCount={}", packageType, records.size());
		} catch (Exception e) {
			LOG.error("Unexpected error while selecting packages by type={}", packageType, e);
			sess.close();
		}
		
		return records;
	}
	
	public List<TourPackage> selectPackagesPage(Integer limit, Integer offset) {
		List<TourPackage> records = new ArrayList<>();
		SqlSession sess = ssf.openSession();
		
		try {
			LOG.info("Selecting packages page. limit={}, offset={}", limit, offset);
			
			PackageMapper repo = sess.getMapper(PackageMapper.class);
			records = repo.selectPackagesPage(limit, offset);
			sess.close();
			
			LOG.info("Select packages page successful. limit={}, offset={}, recordCount={}",
					limit, offset, records.size());
		} catch (Exception e) {
			LOG.error("Unexpected error while selecting packages page. limit={}, offset={}", limit, offset, e);
			sess.close();
		}
		
		return records;
	}

	public int countAllPackages() {
		SqlSession sess = ssf.openSession();
		
		try {
			LOG.info("Counting all packages.");
			
			PackageMapper repo = sess.getMapper(PackageMapper.class);
			Integer count = repo.countAllPackages();
			sess.close();
			
			int result = count == null ? 0 : count;
			LOG.info("Count all packages result={}", result);
			
			return result;
		} catch (Exception e) {
			LOG.error("Unexpected error while counting all packages.", e);
			sess.close();
		}
		
		return 0;
	}
}