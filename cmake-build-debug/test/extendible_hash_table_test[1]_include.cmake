if(EXISTS "/home/hoo/project/bustub/cmake-build-debug/test/extendible_hash_table_test[1]_tests.cmake")
  include("/home/hoo/project/bustub/cmake-build-debug/test/extendible_hash_table_test[1]_tests.cmake")
else()
  add_test(extendible_hash_table_test_NOT_BUILT extendible_hash_table_test_NOT_BUILT)
endif()
