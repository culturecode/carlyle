class SuitePersonObserver < CrierObserver
  def after_create(suite_person)
    case suite_person.relationship
    when 'tenant'
      cry(suite_person.suite, 'now rented by', suite_person.person)
      cry(suite_person.person, 'now rents', suite_person.suite)
    when 'owner'
      cry(suite_person.suite, 'now owned by', suite_person.person)
      cry(suite_person.person, 'now owns', suite_person.suite)
    end
  end

  # Since observers can't catch has_many_through deletions via the collection_singular_ids=ids method,
  # we have these crappy methods to let the suite.tenants/owners after_remove callbacks make use of
  def after_remove_tenant(suite, tenant)
    cry(suite, 'no longer rented by', tenant)
    cry(tenant, 'no longer rents', suite)
  end

  def after_remove_owner(suite, owner)
    cry(suite, 'no longer owned by', owner)
    cry(owner, 'no longer owns', suite)
  end
end
