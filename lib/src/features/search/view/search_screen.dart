import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ott_app/src/global/constants/colors_resources.dart';
import 'package:ott_app/src/global/constants/images.dart';
import 'package:ott_app/src/global/widget/global_container.dart';
import 'package:ott_app/src/global/widget/global_image_loader.dart';
import 'package:ott_app/src/global/widget/global_sized_box.dart';
import 'package:ott_app/src/global/widget/global_text.dart';
import '../../../global/widget/global_textform_field.dart';
import '../../video_details/view/video_details_screen.dart';
import '../controller/search_controller.dart';
import 'widget/search_list_shimmer.dart';
import 'widget/search_menu_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchCon = TextEditingController();
  TextEditingController yearCon = TextEditingController();

  // Filter options
  String selectedType = 'all';
  final List<String> typeOptions = ['all', 'movie', 'series', 'episode'];
  final List<String> typeLabels = ['All', 'Movies', 'Series', 'Episodes'];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchBarController>(builder: (searchBarController) {
      return Scaffold(
        key: scaffoldKey,
        body: GlobalContainer(
          height: size(context).height,
          width: size(context).width,
          color: ColorRes.appBackColor,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sizedBoxH(40),
              const Padding(
                padding: EdgeInsets.only(left: 5),
                child: GlobalText(
                  str: "Search",
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              sizedBoxH(10),

              // Search Text Field
              GlobalTextFormField(
                controller: searchCon,
                hintText: "Search Movie & Series",
                filled: true,
                fillColor: ColorRes.bottomColor,
                isDense: true,
                prefixIcon: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: GlobalImageLoader(
                    imagePath: Images.searchIc,
                    color: ColorRes.white200,
                    height: 20,
                    width: 20,
                    fit: BoxFit.fill,
                  ),
                ),
                sufixIcon: searchCon.text.isNotEmpty
                    ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        searchCon.clear();
                      });
                      searchBarController.clearSearch();
                    },
                    child: const GlobalImageLoader(
                      imagePath: Images.close,
                      color: ColorRes.white200,
                      height: 20,
                      width: 20,
                      fit: BoxFit.fill,
                    ),
                  ),
                )
                    : const SizedBox.shrink(),
                onChanged: (val) async {
                  setState(() {
                    searchCon.text = val;
                  });
                  _performSearch();
                },
              ),

              sizedBoxH(10),

              // Filter Options Row
              Row(
                children: [
                  // Type Filter
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: ColorRes.bottomColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedType,
                          icon: const Icon(Icons.arrow_drop_down, color: ColorRes.white200),
                          dropdownColor: ColorRes.bottomColor,
                          style: const TextStyle(color: ColorRes.white200, fontSize: 14),
                          items: typeOptions.asMap().entries.map((entry) {
                            return DropdownMenuItem<String>(
                              value: entry.value,
                              child: Text(typeLabels[entry.key]),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                selectedType = newValue;
                              });
                              _performSearch();
                            }
                          },
                        ),
                      ),
                    ),
                  ),

                  sizedBoxW(10),

                  // Year Filter
                  Expanded(
                    flex: 1,
                    child: GlobalTextFormField(
                      controller: yearCon,
                      hintText: "Year",
                      filled: true,
                      fillColor: ColorRes.bottomColor,
                      isDense: true,
                      keyboardType: TextInputType.number,
                      maxLength: 4,
                      sufixIcon: yearCon.text.isNotEmpty
                          ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              yearCon.clear();
                            });
                            _performSearch();
                          },
                          child: const Icon(
                            Icons.close,
                            color: ColorRes.white200,
                            size: 16,
                          ),
                        ),
                      )
                          : null,
                      onChanged: (val) {
                        setState(() {
                          yearCon.text = val;
                        });
                        // Only search when year is complete (4 digits) or empty
                        if (val.isEmpty || val.length == 4) {
                          _performSearch();
                        }
                      },
                    ),
                  ),
                ],
              ),

              sizedBoxH(10),

              // Show total results count if available
              if (searchBarController.searchModel?.totalResults != null && searchCon.text.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.only(left: 5, bottom: 10),
                  child: Row(
                    children: [
                      GlobalText(
                        str: "Found ${searchBarController.searchModel!.totalResults} results",
                        fontSize: 14,
                        color: ColorRes.white200,
                      ),
                      if (selectedType != 'all' || yearCon.text.isNotEmpty) ...[
                        const GlobalText(
                          str: " • ",
                          fontSize: 14,
                          color: ColorRes.white200,
                        ),
                        GlobalText(
                          str: _getFilterText(),
                          fontSize: 12,
                          color: ColorRes.white200.withOpacity(0.7),
                        ),
                      ],
                    ],
                  ),
                ),
              ],

              Expanded(child: _buildSearchResults(searchBarController)),
            ],
          ),
        ),
      );
    });
  }

  /// -> Perform search with filters
  void _performSearch() async {
    final searchBarController = Get.find<SearchBarController>();

    if (searchCon.text.isNotEmpty) {
      String? typeFilter = selectedType == 'all' ? null : selectedType;
      String? yearFilter = yearCon.text.isEmpty ? null : yearCon.text;

      await searchBarController.getSearchList(
        search: searchCon.text,
        type: typeFilter,
        year: yearFilter,
      );
    } else {
      searchBarController.clearSearch();
    }
  }

  /// -> Get current filter description
  String _getFilterText() {
    List<String> filters = [];

    if (selectedType != 'all') {
      int index = typeOptions.indexOf(selectedType);
      if (index != -1) {
        filters.add(typeLabels[index]);
      }
    }

    if (yearCon.text.isNotEmpty) {
      filters.add(yearCon.text);
    }

    return filters.join(', ');
  }

  Widget _buildSearchResults(SearchBarController controller) {

    /// -> Loading
    if (controller.isLoading) {
      return searchListShimmer(["", "", "", "", "", "", ""]);
    }

    /// -> Error
    if (controller.hasError) {
      return const Center(
        child: GlobalText(
          str: "Something went wrong. Please try again.",
          fontSize: 16,
          color: ColorRes.white200,
        ),
      );
    }

    /// -> Init Screen
    if (searchCon.text.isEmpty) {
      return const Center(
        child: GlobalText(
          str: "Search for movies and series",
          fontSize: 16,
          color: ColorRes.white200,
        ),
      );
    }

    /// -> Show no results found
    if (controller.searchModel?.search == null || (controller.searchModel?.search?.isEmpty ?? true)) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const GlobalText(
              str: "No results found",
              fontSize: 16,
              color: ColorRes.white200,
            ),
            if (selectedType != 'all' || yearCon.text.isNotEmpty) ...[
              sizedBoxH(10),
              const GlobalText(
                str: "Try adjusting your filters",
                fontSize: 14,
                color: ColorRes.white200,
              ),
              sizedBoxH(10),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedType = 'all';
                    yearCon.clear();
                  });
                  _performSearch();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: ColorRes.bottomColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const GlobalText(
                    str: "Clear Filters",
                    fontSize: 12,
                    color: ColorRes.white200,
                  ),
                ),
              ),
            ],
          ],
        ),
      );
    }

    /// -> Show search results
    return ListView.builder(
      itemCount: controller.searchModel!.search!.length,
      padding: const EdgeInsets.only(bottom: 100),
      shrinkWrap: true,
      itemBuilder: (ctx, index) {
        final searchItem = controller.searchModel!.search![index];

        return SearchMenuWidget(
          img: searchItem.poster ?? "",
          text: searchItem.title ?? "Unknown Title",
          subText: _buildSubtitle(searchItem),
          onTap: () {
            if (searchItem.imdbID != null && searchItem.imdbID!.isNotEmpty) {
              Get.to(()=> VideoDetailsScreen(imdbId: searchItem.imdbID));
            }
          },
        );
      },
    );
  }

  String _buildSubtitle(searchItem) {
    List<String> subtitleParts = [];

    if (searchItem.year != null && searchItem.year!.isNotEmpty) {
      subtitleParts.add(searchItem.year!);
    }

    if (searchItem.type != null && searchItem.type!.isNotEmpty) {
      String type = searchItem.type!;
      type = type[0].toUpperCase() + type.substring(1);
      subtitleParts.add(type);
    }
    return subtitleParts.join(" • ");
  }
}