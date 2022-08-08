module ActiveRecordPlaygroundRunner::SeedsHelpers
  def create_list(klass, count:, &block)
    records_data = count.times.map(&block)
    insert_records(klass, records_data)
  end

  def create_list_for_each_record(klass, records:, count:, &block)
    records_data = records.flat_map { |record| count.times.map { block.(record) } }
    insert_records(klass, records_data)
  end

  private

  def insert_records(klass, records_data)
    ids = klass.insert_all(records_data).map { |data| data["id"] }
    klass.where(id: ids)
  end
end
