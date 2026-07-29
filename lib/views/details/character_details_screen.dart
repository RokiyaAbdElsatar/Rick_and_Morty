import 'package:cached_network_image/cached_network_image.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import '../../core/utils/date_formatter.dart';
import '../../core/utils/responsive.dart';
import '../../core/utils/status_helper.dart';
import '../../core/widgets/responsive_wrapper.dart';
import '../../models/character_model.dart';

class CharacterDetailsScreen extends StatefulWidget {
  final CharacterModel character;

  const CharacterDetailsScreen({
    super.key,
    required this.character,
  });

  @override
  State<CharacterDetailsScreen> createState() => _CharacterDetailsScreenState();
}

class _CharacterDetailsScreenState extends State<CharacterDetailsScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _exportCharacter() async {
    final c = widget.character;
    try {
      final excel = Excel.createExcel();
      final sheet = excel['Character'];

      sheet.appendRow([
        TextCellValue('Name'),
        TextCellValue('Status'),
        TextCellValue('Species'),
        TextCellValue('Gender'),
        TextCellValue('Origin'),
        TextCellValue('Location'),
        TextCellValue('Type'),
        TextCellValue('Episode Count'),
      ]);
      sheet.appendRow([
        TextCellValue(c.name),
        TextCellValue(c.status),
        TextCellValue(c.species),
        TextCellValue(c.gender),
        TextCellValue(c.originName),
        TextCellValue(c.locationName),
        TextCellValue(c.type.isNotEmpty ? c.type : 'N/A'),
        TextCellValue('${c.episodeCount}'),
      ]);

      final dir = await getApplicationDocumentsDirectory();
      final filePath =
          '${dir.path}/${c.name.replaceAll(RegExp(r'[^\w\s]'), '')}.xlsx';
      final fileBytes = excel.encode();
      if (fileBytes != null) {
        await File(filePath).writeAsBytes(fileBytes);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$filePath saved'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Export failed: $e'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final imageHeight = detailImageHeight(context);
    final contentPadding = 20.w;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.character.name),
        actions: [
          IconButton(
            onPressed: _exportCharacter,
            icon: const Icon(Icons.download_rounded),
            tooltip: 'Export to Excel',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: ResponsiveWrapper(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: 'character_${widget.character.id}',
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(28.r),
                  ),
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: widget.character.image,
                        width: double.infinity,
                        height: imageHeight,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          height: imageHeight,
                          color: theme.colorScheme.surfaceContainerHighest,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          height: imageHeight,
                          color: theme.colorScheme.surfaceContainerHighest,
                          child: Icon(
                            Icons.broken_image_rounded,
                            size: 64,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 100.h,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withValues(alpha: 0.6),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 16.h,
                        left: contentPadding,
                        child: Row(
                          children: [
                            _Badge(
                              color: widget.character.status.statusColor,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    widget.character.status.statusIcon,
                                    size: 14.sp,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 6.w),
                                  Text(
                                    widget.character.status.toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.sp,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10.w),
                            _Badge(
                              color: Colors.black.withValues(alpha: 0.4),
                              child: Text(
                                widget.character.species,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      contentPadding,
                      contentPadding,
                      contentPadding,
                      context.isDesktop ? 48.h : 32.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                widget.character.name,
                                style: theme.textTheme.headlineMedium,
                              ),
                            ),
                            if (context.isDesktop) ...[
                              SizedBox(width: 16.w),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 14.w,
                                  vertical: 8.h,
                                ),
                                decoration: BoxDecoration(
                                  color: widget.character.status.statusColor
                                      .withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Text(
                                  widget.character.status,
                                  style: TextStyle(
                                    color:
                                        widget.character.status.statusColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        if (widget.character.type.isNotEmpty) ...[
                          SizedBox(height: 4.h),
                          Text(
                            widget.character.type,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                        SizedBox(height: 24.h),
                        _InfoSection(
                          title: 'Details',
                          children: [
                            _InfoRow(
                              label: 'Gender',
                              value: widget.character.gender,
                              icon: Icons.wc_rounded,
                            ),
                            _Divider(),
                            _InfoRow(
                              label: 'Species',
                              value: widget.character.species,
                              icon: Icons.biotech_rounded,
                            ),
                            _Divider(),
                            _InfoRow(
                              label: 'Type',
                              value: widget.character.type.isNotEmpty
                                  ? widget.character.type
                                  : 'N/A',
                              icon: Icons.category_rounded,
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        _InfoSection(
                          title: 'Location',
                          children: [
                            _InfoRow(
                              label: 'Origin',
                              value: widget.character.originName,
                              icon: Icons.public_rounded,
                            ),
                            _Divider(),
                            _InfoRow(
                              label: 'Current Location',
                              value: widget.character.locationName,
                              icon: Icons.location_on_rounded,
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        _InfoSection(
                          title: 'Stats',
                          children: [
                            _InfoRow(
                              label: 'Episode Count',
                              value:
                                  '${widget.character.episodeCount} episodes',
                              icon: Icons.movie_rounded,
                            ),
                            _Divider(),
                            _InfoRow(
                              label: 'Created',
                              value: widget.character.created.formatApiDate(),
                              icon: Icons.calendar_today_rounded,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final Color color;
  final Widget child;

  const _Badge({required this.color, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: child,
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 0.5,
      indent: 36,
      color: Theme.of(context).colorScheme.outlineVariant,
    );
  }
}

class _InfoSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _InfoSection({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
        SizedBox(height: 10.h),
        Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: Column(
              children: children,
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _InfoRow({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, size: 18.sp,
                color: theme.colorScheme.onPrimaryContainer),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  value,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
