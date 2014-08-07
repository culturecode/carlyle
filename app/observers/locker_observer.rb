class LockerObserver < CrierObserver
  # Add suite change notifications for direct locker updates
  def after_save(locker)
    if locker.suite_id_changed?
      if locker.suite_id_was && suite = Suite.find(locker.suite_id_was)
        cry(suite, 'no longer rents', locker)
      end

      if locker.suite
        cry(locker.suite, 'now rents', locker)
        cry(locker, 'now rented by', locker.suite)
      else
        cry(locker, 'no longer rented')
      end
    end
  end

  # Since observers can't catch has_many_through deletions via the collection_singular_ids=ids method,
  # we have these crappy methods to let the suite.lockers after_remove callbacks make use of
  def after_remove(suite, locker)
    cry(suite, 'no longer rents', locker)
    cry(locker, 'no longer rented')
  end
end
