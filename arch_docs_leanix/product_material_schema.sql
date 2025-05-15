
-- Main table
CREATE TABLE product_material (
    id SERIAL PRIMARY KEY,
    updated_at TEXT DEFAULT TO_CHAR(CURRENT_TIMESTAMP, 'YYYY-MM-DD\"T\"HH24:MI:SS.MS\"Z\"'),
    created_at TEXT DEFAULT TO_CHAR(CURRENT_TIMESTAMP, 'YYYY-MM-DD\"T\"HH24:MI:SS.MS\"Z\"'),
    material_number VARCHAR,
    created_on VARCHAR,
    created_by VARCHAR,
    last_changed_on VARCHAR,
    changed_by VARCHAR,
    maintenance_status VARCHAR,
    material_type VARCHAR,
    industry_sector VARCHAR,
    base_unit_of_measure VARCHAR,
    number_of_sheets VARCHAR,
    gross_weight VARCHAR,
    net_weight VARCHAR,
    volume VARCHAR,
    division VARCHAR,
    number_of_gr_gi VARCHAR,
    length VARCHAR,
    width VARCHAR,
    height VARCHAR,
    packaging_weight VARCHAR,
    packaging_volume VARCHAR,
    weight_tolerance VARCHAR,
    volume_tolerance VARCHAR,
    maximum_level_volume VARCHAR,
    stacking_factor VARCHAR,
    minimum_shelf_life VARCHAR,
    period_indicator VARCHAR,
    total_shelf_life VARCHAR,
    storage_percentage VARCHAR,
    complete_material_status VARCHAR,
    cross_plant_date VARCHAR,
    x_distr_chain_date VARCHAR,
    material_completion_level VARCHAR,
    excess_weight_tolerance VARCHAR,
    excess_volume_tolerance VARCHAR,
    anp_code VARCHAR,
    old_material_number VARCHAR,
    weight_unit VARCHAR,
    product_hierarchy_l6_pack_quantity VARCHAR,
    material_status VARCHAR,
    product_hierarchy_l3_brand VARCHAR,
    volume_unit VARCHAR
);

-- Subtables
CREATE TABLE product_material_additional_data (
    id SERIAL PRIMARY KEY,
    product_material_id INTEGER NOT NULL REFERENCES product_material(id) ON DELETE CASCADE,
    external_long_material_number VARCHAR,
    maximum_allowed_capacity_of_packaging_material_information VARCHAR,
    overcapacity_tolerance_of_the_handling_unit VARCHAR,
    maximum_packing_length_of_packaging_material VARCHAR,
    maximum_packing_width_of_packaging_material VARCHAR,
    maximum_packing_height_of_packaging_material VARCHAR,
    quarantine_period VARCHAR,
    medium VARCHAR,
    commodity VARCHAR,
    maturation_time VARCHAR,
    required_maximum_shelf_life VARCHAR
);

CREATE TABLE product_material_material_texts (
    id SERIAL PRIMARY KEY,
    product_material_id INTEGER NOT NULL REFERENCES product_material(id) ON DELETE CASCADE,
    language_key VARCHAR,
    material_description VARCHAR,
    sap_language_code VARCHAR
);

CREATE TABLE product_material_plant_data (
    id SERIAL PRIMARY KEY,
    product_material_id INTEGER NOT NULL REFERENCES product_material(id) ON DELETE CASCADE,
    plant_name VARCHAR,
    maintenance_status VARCHAR,
    flag_material_for_deletion_at_plant_level VARCHAR,
    valuation_category VARCHAR,
    batch_management_indicator_internal VARCHAR,
    plant_specific_material_status VARCHAR,
    date_from_which_the_plant_specific_material_status_is_valid VARCHAR,
    purchasing_group VARCHAR,
    unit_of_issue VARCHAR,
    material_mrp_profile VARCHAR,
    mrp_type VARCHAR,
    mrp_controller_materials_planner VARCHAR,
    planned_delivery_time_in_days VARCHAR,
    goods_receipt_processing_time_in_days VARCHAR,
    lot_size_materials_planning VARCHAR,
    procurement_type VARCHAR,
    special_procurement_type VARCHAR,
    reorder_point VARCHAR,
    safety_stock VARCHAR,
    minimum_lot_size VARCHAR,
    maximum_lot_size VARCHAR,
    fixed_lot_size VARCHAR,
    maximum_stock_level VARCHAR,
    discontinuation_indicator VARCHAR,
    follow_up_material VARCHAR,
    loading_group VARCHAR
);

CREATE TABLE product_material_uom (
    id SERIAL PRIMARY KEY,
    product_material_id INTEGER NOT NULL REFERENCES product_material(id) ON DELETE CASCADE,
    alternative_unit_of_measure VARCHAR,
    numerator VARCHAR,
    denominator VARCHAR,
    length VARCHAR,
    width VARCHAR,
    height VARCHAR,
    volume VARCHAR,
    gross_weight VARCHAR,
    remaining_volume_percentage VARCHAR,
    maximum_stacking_factor VARCHAR,
    capacity_usage VARCHAR,
    volume_unit VARCHAR,
    ean_type VARCHAR,
    ean_upc_gtin VARCHAR
);

CREATE TABLE product_material_sales_data (
    id SERIAL PRIMARY KEY,
    product_material_id INTEGER NOT NULL REFERENCES product_material(id) ON DELETE CASCADE,
    sales_org VARCHAR,
    sales_org_name VARCHAR,
    distributionchannelid VARCHAR,
    distribution_channel_name VARCHAR,
    material_statistics_group VARCHAR,
    volume_rebate_group VARCHAR,
    commission_group VARCHAR,
    minimum_order_quantity_in_base_unit_of_measure VARCHAR,
    minimum_delivery_quantity_in_delivery_note_processing VARCHAR,
    minimum_make_to_order_quantity VARCHAR,
    delivery_unit VARCHAR,
    unit_of_measure_of_delivery_unit VARCHAR,
    sales_unit VARCHAR,
    delivering_plant_own_or_external VARCHAR,
    product_hierarchy VARCHAR,
    pricing_reference_material VARCHAR,
    material_pricing_group VARCHAR,
    account_assignment_group_for_material VARCHAR,
    material_group_1 VARCHAR,
    material_group_2 VARCHAR,
    material_group_3 VARCHAR,
    material_group_4 VARCHAR,
    material_group_5 VARCHAR,
    assortment_grade VARCHAR,
    external_assortment_priority VARCHAR
);

CREATE TABLE product_material_master_material_valuation (
    id SERIAL PRIMARY KEY,
    product_material_id INTEGER NOT NULL REFERENCES product_material(id) ON DELETE CASCADE,
    standard_price VARCHAR,
    standard_price_in_previous_year VARCHAR,
    valuation_area VARCHAR,
    valuation_price_level_1 VARCHAR,
    valuation_price_level_2 VARCHAR
);

CREATE TABLE product_material_material_european_number (
    id SERIAL PRIMARY KEY,
    product_material_id INTEGER NOT NULL REFERENCES product_material(id) ON DELETE CASCADE,
    unit_of_measure VARCHAR,
    ean_upc VARCHAR,
    category_ean VARCHAR
);


-- Function to auto-update the 'updated_at' field
CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger to invoke the function before any update on the product_material table
CREATE TRIGGER trg_set_updated_at
BEFORE UPDATE ON product_material
FOR EACH ROW
EXECUTE FUNCTION set_updated_at();