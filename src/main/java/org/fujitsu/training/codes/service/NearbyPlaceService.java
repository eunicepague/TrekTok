package org.fujitsu.training.codes.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.fujitsu.training.codes.dao.NearbyPlaceMapper;
import org.fujitsu.training.codes.model.data.NearbyPlace;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class NearbyPlaceService {

	private static final Logger LOG = LogManager.getLogger(NearbyPlaceService.class);

	@Autowired
	private SqlSessionFactory ssf;

	public List<NearbyPlace> selectAllNearbyPlaces() {
		List<NearbyPlace> records = new ArrayList<>();
		SqlSession sess = ssf.openSession();

		try {
			LOG.info("Selecting all nearby places.");

			NearbyPlaceMapper repo = sess.getMapper(NearbyPlaceMapper.class);
			records = repo.selectAllNearbyPlaces();
			sess.close();

			LOG.info("Select all nearby places successful. recordCount={}", records.size());
		} catch (Exception e) {
			LOG.error("Unexpected error while selecting all nearby places.", e);
			sess.close();
		}

		return records;
	}

	public NearbyPlace selectNearbyPlaceById(Integer placeId) {
		NearbyPlace rec = null;
		SqlSession sess = ssf.openSession();

		try {
			LOG.info("Selecting nearby place by placeId={}", placeId);

			NearbyPlaceMapper repo = sess.getMapper(NearbyPlaceMapper.class);
			rec = repo.selectNearbyPlaceById(placeId);
			sess.close();

			if (rec != null) {
				LOG.info("Nearby place found for placeId={}", placeId);
			} else {
				LOG.info("No nearby place found for placeId={}", placeId);
			}
		} catch (Exception e) {
			LOG.error("Unexpected error while selecting nearby place by placeId={}", placeId, e);
			sess.close();
		}

		return rec;
	}

	public List<NearbyPlace> selectByPackageId(Integer packageId) {
		List<NearbyPlace> records = new ArrayList<>();
		SqlSession sess = ssf.openSession();

		try {
			LOG.info("Selecting nearby places by packageId={}", packageId);

			NearbyPlaceMapper repo = sess.getMapper(NearbyPlaceMapper.class);
			records = repo.selectByPackageId(packageId);
			sess.close();

			LOG.info("Select nearby places by packageId successful. packageId={}, recordCount={}", packageId, records.size());
		} catch (Exception e) {
			LOG.error("Unexpected error while selecting nearby places by packageId={}", packageId, e);
			sess.close();
		}

		return records;
	}

	public boolean insertNearbyPlace(NearbyPlace rec) {
		SqlSession sess = ssf.openSession();

		try {
			LOG.info("Inserting nearby place. packageId={}, placeName={}", rec.getPackageId(), rec.getPlaceName());

			NearbyPlaceMapper repo = sess.getMapper(NearbyPlaceMapper.class);
			Integer count = repo.insertNearbyPlace(rec);
			sess.commit();
			sess.close();

			if (count > 0) {
				LOG.info("Nearby place inserted successfully. placeName={}", rec.getPlaceName());
			} else {
				LOG.error("Nearby place insert failed. placeName={}", rec.getPlaceName());
			}

			return count > 0;
		} catch (Exception e) {
			LOG.error("Unexpected error while inserting nearby place. placeName={}", rec.getPlaceName(), e);
			sess.rollback();
			sess.close();
		}

		return false;
	}

	public boolean updateNearbyPlace(NearbyPlace rec) {
		SqlSession sess = ssf.openSession();

		try {
			LOG.info("Updating nearby place. placeId={}, placeName={}", rec.getPlaceId(), rec.getPlaceName());

			NearbyPlaceMapper repo = sess.getMapper(NearbyPlaceMapper.class);
			Integer count = repo.updateNearbyPlace(rec);
			sess.commit();
			sess.close();

			if (count > 0) {
				LOG.info("Nearby place updated successfully. placeId={}", rec.getPlaceId());
			} else {
				LOG.error("Nearby place update failed. placeId={}", rec.getPlaceId());
			}

			return count > 0;
		} catch (Exception e) {
			LOG.error("Unexpected error while updating nearby place. placeId={}", rec.getPlaceId(), e);
			sess.rollback();
			sess.close();
		}

		return false;
	}

	public boolean deleteNearbyPlace(Integer placeId) {
		SqlSession sess = ssf.openSession();

		try {
			LOG.info("Deleting nearby place. placeId={}", placeId);

			NearbyPlaceMapper repo = sess.getMapper(NearbyPlaceMapper.class);
			Integer count = repo.deleteNearbyPlace(placeId);
			sess.commit();
			sess.close();

			if (count > 0) {
				LOG.info("Nearby place deleted successfully. placeId={}", placeId);
			} else {
				LOG.error("Nearby place delete failed. placeId={}", placeId);
			}

			return count > 0;
		} catch (Exception e) {
			LOG.error("Unexpected error while deleting nearby place. placeId={}", placeId, e);
			sess.rollback();
			sess.close();
		}

		return false;
	}
}