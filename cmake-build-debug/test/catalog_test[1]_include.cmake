if(EXISTS "/home/hoo/project/bustub/cmake-build-debug/test/catalog_test[1]_tests.cmake")
  include("/home/hoo/project/bustub/cmake-build-debug/test/catalog_test[1]_tests.cmake")
else()
  add_test(catalog_test_NOT_BUILT catalog_test_NOT_BUILT)
endif()