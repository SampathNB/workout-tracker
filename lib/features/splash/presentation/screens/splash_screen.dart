import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:gym_track/core/constants/app_constants.dart';

/// Brand splash shown briefly on cold start.
class SplashScreen extends HookWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 900),
    );
    final fade = useMemoized(
      () => CurvedAnimation(parent: controller, curve: Curves.easeOut),
      [controller],
    );
    final scale = useMemoized(
      () => Tween<double>(begin: 0.92, end: 1).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOutBack),
      ),
      [controller],
    );

    useEffect(() {
      controller.forward();
      return null;
    }, [controller]);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Center(
        child: FadeTransition(
          opacity: fade,
          child: ScaleTransition(
            scale: scale,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        colorScheme.primary,
                        colorScheme.tertiary,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(28),
                    child: Icon(
                      Icons.fitness_center_rounded,
                      size: 56,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                Text(
                  AppConstants.appName,
                  style: textTheme.displaySmall?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Train smarter. Track better.',
                  style: textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
