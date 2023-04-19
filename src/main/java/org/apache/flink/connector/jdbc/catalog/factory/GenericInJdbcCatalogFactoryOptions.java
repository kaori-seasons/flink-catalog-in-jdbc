package org.apache.flink.connector.jdbc.catalog.factory;

import org.apache.flink.annotation.Internal;
import org.apache.flink.configuration.ConfigOption;
import org.apache.flink.configuration.ConfigOptions;
import org.apache.flink.table.catalog.CommonCatalogOptions;

@Internal
public class GenericInJdbcCatalogFactoryOptions {

  public static final String IDENTIFIER = "generic_in_jdbc";

  public static final ConfigOption<String> DEFAULT_DATABASE =
      ConfigOptions.key(CommonCatalogOptions.DEFAULT_DATABASE_KEY).stringType().noDefaultValue();

  public static final ConfigOption<String> USERNAME =
      ConfigOptions.key("username").stringType().noDefaultValue();

  public static final ConfigOption<String> PASSWORD =
      ConfigOptions.key("password").stringType().noDefaultValue();

  public static final ConfigOption<String> URL =
      ConfigOptions.key("url").stringType().noDefaultValue();

  private GenericInJdbcCatalogFactoryOptions() {}
}
