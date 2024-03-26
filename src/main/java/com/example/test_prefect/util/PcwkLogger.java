package com.example.test_prefect.util;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

//LOG.DEBUG 체크시 사용
public interface PcwkLogger {
    Logger LOG = LogManager.getLogger(PcwkLogger.class);
}
