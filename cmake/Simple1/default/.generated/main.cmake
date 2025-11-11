# cmake files support debug production
include("${CMAKE_CURRENT_LIST_DIR}/rule.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/file.cmake")

set(Simple1_default_library_list )

# Handle files with suffix (s|S|asm|ASM|msa|MSA), for group default-PIC-AS
if(Simple1_default_default_PIC_AS_FILE_TYPE_assemble)
add_library(Simple1_default_default_PIC_AS_assemble OBJECT ${Simple1_default_default_PIC_AS_FILE_TYPE_assemble})
    Simple1_default_default_PIC_AS_assemble_rule(Simple1_default_default_PIC_AS_assemble)
    list(APPEND Simple1_default_library_list "$<TARGET_OBJECTS:Simple1_default_default_PIC_AS_assemble>")
endif()

add_executable(Simple1_default_image_Y8BtFlFE ${Simple1_default_library_list})

set_target_properties(Simple1_default_image_Y8BtFlFE PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${Simple1_default_output_dir})
set_target_properties(Simple1_default_image_Y8BtFlFE PROPERTIES OUTPUT_NAME "default")
set_target_properties(Simple1_default_image_Y8BtFlFE PROPERTIES SUFFIX ".elf")

target_link_libraries(Simple1_default_image_Y8BtFlFE PRIVATE ${Simple1_default_default_PIC_AS_FILE_TYPE_link})


# Add the link options from the rule file.
Simple1_default_link_rule(Simple1_default_image_Y8BtFlFE)



